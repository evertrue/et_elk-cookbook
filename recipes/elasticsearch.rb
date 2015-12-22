#
# Cookbook Name:: et_elk
# Recipe:: elasticsearch
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.

include_recipe 'java'
include_recipe 'storage'

node.set['et_elk']['elasticsearch']['custom_config']['discovery.zen.ping.unicast.hosts'] =
  search(:node, node['et_elk']['elasticsearch']['search_query']).map(&:ipaddress)

include_recipe 'chef-sugar'

elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch'

#
# CONFIGURATION
#

elasticsearch_configure 'elasticsearch' do
  allocated_memory "#{(node['memory']['total'].to_i * 0.4).floor / 1024}m"
  if node['storage']['ephemeral_mounts'] &&
     node['storage']['ephemeral_mounts'].any?
    path_data(
      package: node['storage']['ephemeral_mounts'].map do |mount|
        "#{mount}/elasticsearch/data"
      end.sort.join(',')
    )
  end
  configuration node['et_elk']['elasticsearch']['custom_config']
end
elasticsearch_service 'elasticsearch'

#
# PLUGINS
#

node['et_elk']['elasticsearch']['plugins'].each do |plugin_name, plugin_conf|
  elasticsearch_plugin plugin_name do
    if plugin_conf['url']
      url(
        if plugin_conf['version']
          "#{plugin_conf['url']}/#{plugin_conf['version']}"
        else
          plugin_conf['url']
        end
      )
    end
  end
end
