#
# Cookbook Name:: infra_hardening
# Recipe:: limit_access
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


paths = %w(/usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin) + node['os-hardening']['env']['extra_user_paths']
paths.each do |folder|
  execute "remove write permission from #{folder}" do
    command "chmod go-w -R #{folder}"
    not_if "find #{folder}  -perm -go+w -type f | wc -l | egrep '^0$'"
  end
end

# shadow must only be accessible to user root
file '/etc/shadow' do
  owner 'root'
  group 'root'
  mode '0600'
end

# su must only be accessible to user and group root
file '/bin/su' do
  owner 'root'
  group 'root'
  mode '0750'
  not_if { node['os-hardening']['security']['users']['allow'].include?('change_user') }
end
