log_level                :info
log_location             STDOUT
node_name                'njuchef'
client_key               '/home/nju/chef-repo/.chef/njuchef.pem'
validation_client_name   'chef-validator'
validation_key           '/home/nju/chef-repo/.chef/chef-validator.pem'
chef_server_url          'https://master.example.com:443'
syntax_check_cache_path  '/home/nju/chef-repo/.chef/syntax_check_cache'
cookbook_path [ '/home/helo/Workspace/chef-repo/cookbooks' ]
