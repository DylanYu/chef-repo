#
# Cookbook Name:: cloud
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cloud_magic "test_cloud_magic" do
  action :create
  magic false
  cloud "home/helo/testH"
end
