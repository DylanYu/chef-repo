chef_gem "aviator" do
  action :install
end

chef_gem "mysql2" do
  action :install
end

require 'aviator'
require "mysql"
ostool_cluster "test_create_cluster" do
  action node[:cluster][:action]
  name node[:cluster][:name]
  node_type node[:cluster][:node_type]
  number node[:cluster][:number]
  image node[:cluster][:image]
  username node[:cluster][:username]
  userpw node[:cluster][:userpw]
end
