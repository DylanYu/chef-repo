def whyrun_supported?
  return true
end

action :create do
  if @current_resource.exist
    Chef::Log.info "server #{@new_resource} already exists - do nothing."
  else
    converge_by("We will create server #{@new_resource}.") do
      create_server
    end
  end
end

action :delete do
end

def load_current_resource
  @current_resource = Chef::Resource::OstoolServer.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  if server_exist?(@current_resource.name)
    @current_resource.exist=true
  else
    @current_resource.exist = false
  end
end

def create_server
  session = Aviator::Session.new(
            :config_file => Pathname.new(__FILE__).join('..', '..', 'files', 'aviator.yml').expand_path,
            :environment => :default,
            :log_file    => Pathname.new(__FILE__).join('..', '..', 'files', 'aviator.log').expand_path
            )
  session.authenticate

  response = session.compute_service.request(:create_server) do |params|
              params.name = @new_resource.name
              params.flavor_ref = @new_resource.flavor_ref
              params.image_ref = @new_resource.image_ref
              params.networks = @new_resource.networks
              params.admin_pass = @new_resource.admin_pass
             end
  puts response.body
  Chef::Log.info "response of create_server: #{response.body}"
end

def server_exist?(name)
  return false
end

