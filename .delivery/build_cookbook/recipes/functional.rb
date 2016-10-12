#
# Cookbook Name:: build_cookbook
# Recipe:: functional
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
search_terms = []
get_all_project_cookbooks.each do |cookbook|
  search_terms << "recipe:#{cookbook.name}*"
end

unless search_terms.empty?
  search_query = "(#{search_terms.join(' OR ')}) " \
                 "AND chef_environment:#{delivery_environment}"

  my_nodes = delivery_chef_server_search(:node, search_query)

  my_nodes.map!(&:name)

  delivery_push_job "deploy_#{node['delivery']['change']['project']}" do
    command 'base-compliance-scan'
    nodes my_nodes
  end
end
