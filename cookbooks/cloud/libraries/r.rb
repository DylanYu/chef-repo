require 'chef/resource'

class Chef
  class Resource
    class CloudMagic < Chef::Resource
      
      def initialize(name, run_context=nil)
        super
        @resource_name = :cloud_magic
        @provider = Chef::Provider::CloudMagic
        @action = :create
        @allowed_actions = [:create, :remove]

        @magic = true
        @cloud = name
      end
      
      def magic(arg=nil)
        set_or_return(:magic, arg, :kind_of => [TrueClass, FalseClass])
      end

      def cloud(arg=nil)
        set_or_return(:cloud, arg, :kind_of => String)
      end
    end
  end
end
