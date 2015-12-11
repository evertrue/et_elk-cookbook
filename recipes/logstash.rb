#
# Cookbook Name:: et_elk
# Recipe:: logstash
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.

instance_name = 'server'

logstash_instance instance_name

logstash_service instance_name do
  method 'native'
end

logstash_basedir = node['logstash']['instance_default']['basedir']

###########
# Plugins #
###########
node['et_elk']['logstash']['plugins'].each do |plugin|
  logstash_plugins plugin do
    instance instance_name
    not_if "#{logstash_basedir}/#{instance_name}/bin/plugin list | grep #{plugin}"
  end
end
