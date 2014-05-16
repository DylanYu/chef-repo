def whyrun_supported?
    true
end

action :create do
    if @current_resource.exists_and_same_content
        Chef::Log.info "#{ @new_resource } already exists and same content - we will do nothing here."
    else
        converge_by("We will create #{ @new_resource }") do
            create_file_and_modify_content
        end
    end
end

def load_current_resource
    @current_resource = Chef::Resource::FileMaintainerCreateFile.new(@new_resource.path)
    @current_resource.path(@new_resource.path)
    @current_resource.content(@new_resource.content)

    if file_exists_and_same_content?(@current_resource.path)
        @current_resource.exists_and_same_content = true
    end
end

def create_file_and_modify_content
    file_path = new_resource.path
    ::File.open(file_path, 'w') {|f| f.write(new_resource.content)}
end

def file_exists_and_same_content?(path)
    if !::File.file?(path)
        return false
    else
        ::File.open(path, 'r') do |f|
            real_content = f.read()
            return real_content == new_resource.content
        end
    end
end
