def whyrun_supported?
  return true
end

action :create do
  if @current_resource.exist
    Chef::Log.info "network #{@new_resource} already exists - nothing will do."
  else
    converge_by("We will create network #{@new_resource}.") do
      create_network
    end
  end
end

action :delete do
end

def load_current_resource
  @current_resource = Chef::Resource::OstoolNetwork.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  if network_exist?(@current_resource.name)
    @current_resource.exist = true
  else
    @current_resource.exist = false
  end
end

def create_network
  IO.popen("python /home/nju/create_network.py #{@new_resource.name}")
end

def network_exist?(name)
  IO.popen("python /home/nju/test_network_exist.py #{name}") do |f|
    query_result =  f.gets.chomp # delete white space
    if query_result == "true"
      return true
    else
      return false
    end
  end
end
