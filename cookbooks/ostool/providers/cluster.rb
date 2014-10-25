def whyrun_supported?
  return true
end

action :create do
  if @current_resource.exist
    Chef::Log.info "cluster #{@new_resource} already exists - do nothing."
  else
    converge_by("We will create cluster #{@new_resource}.") do
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
  session = Aviator::Session.new(
            :config_file => Pathname.new(__FILE__).join('..', '..', 'files', 'aviator.yml').expand_path,
            :environment => :default,
            :log_file    => Pathname.new(__FILE__).join('..', '..', 'files', 'aviator.log').expand_path
            )
  session.authenticate

  flavor_ref = '1'
  if @new_resource.node_type == 'small'
    flavor_ref = '2'
  elsif @new_resource.node_type == 'medium'
    flavor_ref = '3'
  elsif @new_resource.node_type == 'large'
    flavor_ref = '4'
  end
  number = @new_resource.number
  image_ref = 'fb55faac-7953-4a76-8761-251646a3001e' if @new_resource.image == 'ubuntu'
  networks = [{"uuid"=>"9ac45086-0a5a-4692-8dd1-a31188ebac7c"}]
  username = @new_resource.username
  userpw = @new_resource.userpw

  number.times {
    response = session.compute_service.request(:create_server) do |params|
                params.name = username
                params.flavor_ref = flavor_ref
                params.image_ref = image_ref
                params.networks = networks
                params.admin_pass = userpw
               end
    puts response.body
    Chef::Log.info "response of create_cluster: #{response.body}"
  }
end

def cluster_exist?(name)
  return false
end
