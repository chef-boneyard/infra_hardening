#
# Cookbook Name:: infra_hardening
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Remove Telnet
# include_recipe 'infra_hardening::purge_telnet'

# Lockdown access
include_recipe 'infra_hardening::limit_access'
