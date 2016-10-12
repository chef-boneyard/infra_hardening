#
# Cookbook Name:: build_cookbook
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#include_recipe 'delivery-truck::deploy'

search_terms = []
get_all_project_cookbooks.each do |cookbook|
  search_terms << "recipes:#{cookbook.name}*"
end

log "Search_Terms: #{search_terms}"

unless search_terms.empty?
  search_query = "(#{search_terms.join(' OR ')}) " \
                 "AND chef_environment:#{delivery_environment} "

                 log "Search_Query: #{search_query}"


  my_nodes = delivery_chef_server_search(:node, search_query)

  log "Nodes: #{my_nodes}"

  my_nodes.map!(&:name)

  delivery_push_job "deploy_#{node['delivery']['change']['project']}" do
    command 'chef-client'
    nodes my_nodes
  end
end
