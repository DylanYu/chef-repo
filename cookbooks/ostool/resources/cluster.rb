actions :create, :delete
default_action :create

attribute :name,      :kind_of => String, :required => true, :name_attribute => true
attribute :node_type, :kind_of => String, :required => true
attribute :number,    :kind_of => Integer, :required => true
attribute :image,     :kind_of => String, :required => true
attribute :network,   :kind_of => String
attribute :username,  :kind_of => String
attribute :userpw,    :kind_of => String

attr_accessor :exist
