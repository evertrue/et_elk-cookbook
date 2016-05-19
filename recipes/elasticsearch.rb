#
# Cookbook Name:: et_elk
# Recipe:: elasticsearch
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.

if Chef::Config[:solo]
  raise 'This recipe requires Search which is not available on Chef Solo'
end

include_recipe 'java'
include_recipe 'storage'

node.set['et_elk']['elasticsearch']['custom_config']['discovery.zen.ping.unicast.hosts'] =
  search(:node, node['et_elk']['elasticsearch']['search_query']).map(&:ipaddress)

elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch'

#
# CONFIGURATION
#

# The complicated logic of figuring out where we're going to put all this data
if node['et_elk']['storage_type'] == 'ebs'
  unless node['storage']['ebs_mounts']
    fail 'Selected storage type is ebs but no mounts are available'
  end
  mounts = node['storage']['ebs_mounts']
elsif node['storage']['ephemeral_mounts']
  mounts = node['storage']['ephemeral_mounts']
end

elasticsearch_configure 'elasticsearch' do
  allocated_memory "#{(node['memory']['total'].to_i * 0.4).floor / 1024}m"
  path_data(package: mounts.map { |mount| "#{mount}/elasticsearch/data" }.sort.join(',')) if mounts
  configuration node['et_elk']['elasticsearch']['custom_config']
end
elasticsearch_service 'elasticsearch'

#
# PLUGINS
#

if node['platform_family'] == 'debian'
  execute 'update-ca-certificates' do
    command 'update-ca-certificates -f'
  end
end

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
