actions :create
default_action :create

attribute :path, :name_attribute => true, :kind_of => String, :required =>true
attribute :content, :kind_of => String

attr_accessor :exists_and_same_content
