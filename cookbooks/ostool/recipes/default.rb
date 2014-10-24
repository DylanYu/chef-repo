chef_gem "aviator" do
  action :install
end

require 'aviator'
ostool_cluster "test_create_cluster" do
  action :create
  name 'test_cluster'
  node_type 'medium'
  number 3
  image 'ubuntu'
  username 'testuser'
  userpw 'cs'
end
