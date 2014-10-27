def whyrun_supported?
  return true
end

action :create do
  if @current_resource.exist
    Chef::Log.info "cluster #{@new_resource} already exists - do nothing."
  else
    converge_by("We will create cluster #{@new_resource} according to your config.") do
      create_cluster
    end
  end
end

action :delete do
end

def load_current_resource
  @current_resource = Chef::Resource::OstoolCluster.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  if cluster_exist?(@current_resource.name)
    @current_resource.exist=true
  else
    @current_resource.exist = false
  end
end

def create_cluster
  begin
    con = Mysql.new('localhost', 'root', 'cs', 'chef')
    rs = con.query "select * from cluster"
    cluster_name = @new_resource.name
    duplicate_cluster = false
    rs.each_hash do |row|
      if row['name'] == @new_resource.name # TODO why canot use symbol
        puts ""
        puts "Duplicate cluster found."
        duplicate_cluster = true
      end
    end

    rs = con.query "select * from machine where cluster_name = '#{@new_resource.name}'"
    cnt_size = rs.num_rows
    number = @new_resource.number - cnt_size

    if !duplicate_cluster
      con.query "insert into cluster(name) values('#{cluster_name}')"
    end

    if number == 0
      puts ""
      puts "------delta is 0, nothing will happen----------"
      return
    end

    flavor_ref = '1'
    if @new_resource.node_type == 'small'
      flavor_ref = '2'
    elsif @new_resource.node_type == 'medium'
      flavor_ref = '3'
    elsif @new_resource.node_type == 'large'
      flavor_ref = '4'
    end
    image_ref = 'fb55faac-7953-4a76-8761-251646a3001e' if @new_resource.image == 'ubuntu'
    networks = [{"uuid"=>"9ac45086-0a5a-4692-8dd1-a31188ebac7c"}]
    username = @new_resource.username
    userpw = @new_resource.userpw

    session = Aviator::Session.new(
              :config_file => Pathname.new(__FILE__).join('..', '..', 'files', 'aviator.yml').expand_path,
              :environment => :default,
              :log_file    => Pathname.new(__FILE__).join('..', '..', 'files', 'aviator.log').expand_path
              )
    session.authenticate

    # Create
    number.times {
      response = session.compute_service.request(:create_server) do |params|
                  params.name = cluster_name + "_" + username
                  params.flavor_ref = flavor_ref
                  params.image_ref = image_ref
                  params.networks = networks
                  params.admin_pass = userpw
                 end
      puts response.body
      #puts username + "," + cluster_name + "," + response.body[:server][:id]
      con.query "insert into machine(host_id, name, cluster_name) values('#{response.body[:server][:id]}', '#{username}','#{cluster_name}')"
      Chef::Log.info "response of create_cluster: #{response.body}"
    }

    # Delete redundant machine
    if number < 0
      number = -number
      rs = con.query "select * from machine where cluster_name = '#{@new_resource.name}'"
      number.times do
        host_id = rs.fetch_row[0]
        response = session.compute_service.request(:delete_server) do |params|
          params.id = host_id
        end
        #bug for response.body in aviator
        con.query "delete from machine where host_id = '#{host_id}'"
      end
    end
  rescue Mysql::Error => e
    puts e.errno
    puts e.error
  ensure
    con.close if con
  end

end

def cluster_exist?(name)
  return false
end
