actions :create, :delete
default_action :create

attribute :name,        :kind_of => String, :required => true, :name_attribute => true
attribute :flavor_ref,   :kind_of => String, :required => true
attribute :image_ref,    :kind_of => String, :required => true
attribute :networks,     :kind_of => Array
attribute :admin_pass,   :kind_of => String

attr_accessor :exist
