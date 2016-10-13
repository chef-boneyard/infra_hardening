#
# Cookbook Name:: infra_hardening
# Recipe:: purge_telnet
#
# Copyright (c) 2016 Yvo van Doorn, All Rights Reserved.

case node['platform']
  when 'debian', 'ubuntu'
    package 'telnet' do
      action :purge
    end
  when 'centos', 'redhat', 'amazon', 'scientific', 'oracle'
    package 'telnet-server' do
      action :purge
    end
end
