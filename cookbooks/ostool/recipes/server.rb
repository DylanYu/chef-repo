#
# Cookbook Name:: ostool
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

chef_gem "aviator" do
  action :install
end

require 'aviator'
ostool_server "test_create_server" do
  action :create
  flavor_ref '3'
  image_ref 'fb55faac-7953-4a76-8761-251646a3001e'
  networks [{"uuid"=>"9ac45086-0a5a-4692-8dd1-a31188ebac7c"}]
end

#ostool_network "chef_test" do
#  action :create
#end
