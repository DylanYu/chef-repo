#
# Cookbook Name:: cmd-executor
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

filename = "test_neutron.py"

# will execute every time
execute 'execute_python' do
  cwd '/home/nju/api/osdk/tests/neutron/'
  command "python #{filename}"
  path ["$PATH", "/home/nju/api"]
end

file "api_config" do
    owner 'nju'    
    group "nju"    
    mode '0640' 
    path '/home/nju/api_config'
    action :create
    content 'test file'
end

