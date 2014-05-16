#
# Cookbook Name:: testbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
file_maintainer_create_file "/home/nju/test_create_file" do
    content '123456'
    action :create
end
