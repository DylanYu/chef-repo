class Chef
  class Provider
    class CloudMagic < Chef::Provider
      def load_current_resource
        @current_resource ||= Chef::Resource::CloudMagic.new(@new_resource.name)
        @current_resource.magic(@new_resource.magic)
        @current_resource.cloud(@new_resource.cloud)
        @current_resource
      end

      def action_create
        IO::File.open(@current_resource.cloud, 'w') {|f| f.write("test")}
      end

      def action_remove
        IO::File.delete(@current_resource.cloud)
      end

    end
  end
end
