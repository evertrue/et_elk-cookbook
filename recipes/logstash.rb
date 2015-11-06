#
# Cookbook Name:: elk_logstash
# Recipe:: default
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.

node.set['et_elk']['logstash']['server']['lumberjack']['host'] = '0.0.0.0'

name = 'server'

logstash_instance name do
  action :create
end

logstash_service name do
  action [:enable]
  method 'native'
end

logstash_config name do
  action [:create]
  notifies :restart, "logstash_service[#{name}]"
end
# ^ see `.kitchen.yml` for example attributes to configure templates.

node['et_elk']['logstash']['plugins'].each do |plugin|
  logstash_plugins plugin do
    instance name
    action [:create]
    not_if "#{node['logstash']['instance_default']['basedir']}/#{name}/bin/plugin list | grep #{plugin}"
  end
end

logstash_pattern name do
  action [:create]
end

# This needs to be updated to be cleaner, like in elk_forwarder
%w(key certificate).each do |c|
  ssl_thing = data_bag_item(
    node['elk_logstash']['certs']["#{c}_data_bag"],
    node['elk_logstash']['certs']["#{c}_data_bag_item"]
  )[node['elk_logstash']['certs']["#{c}_data_bag_item_key"]]

  directory File.dirname(node['elk']['server']['lumberjack']["ssl #{c}"]) do
    recursive true
  end

  fail "Need SSL #{c} couldn't find it" if ssl_thing.nil? || ssl_thing.empty?

  file node['elk']['server']['lumberjack']["ssl #{c}"] do
    content ssl_thing
    sensitive true
    notifies :restart, 'logstash_service[server]'
  end
end
