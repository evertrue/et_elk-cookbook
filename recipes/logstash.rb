#
# Cookbook Name:: et_elk
# Recipe:: logstash
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.

node.set['et_elk']['logstash']['server']['config']['input']['lumberjack']['host'] = '0.0.0.0'

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
    not_if "#{node['logstash']['instance_default']['basedir']}/" \
           "#{name}/bin/plugin list | grep #{plugin}"
  end
end

logstash_pattern name do
  action [:create]
end
