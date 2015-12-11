#
# Cookbook Name:: et_elk
# Recipe:: logstash
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.


name = 'server'

logstash_instance name


logstash_service instance_name do
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
    not_if "#{node['logstash']['instance_default']['basedir']}/" \
           "#{name}/bin/plugin list | grep #{plugin}"
  end
end

logstash_pattern name do
  action [:create]
end
