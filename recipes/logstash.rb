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

####################
#  Inputs/Outputs  #
####################
node['et_elk']['server']['config'].each do |type, type_conf|
  type_conf.each do |module_name, module_conf|
    template "#{logstash_basedir}/#{instance_name}/etc/conf.d/#{type}_#{module_name}" do
      source 'filter.erb'
      owner node['logstash']['user']
      group node['logstash']['group']
      variables(
        type: type,
        module_name: module_name,
        module_conf: ::EtElk::Helpers.generate_module_config(module_conf, 4)
      )
      notifies :restart, "logstash_service[#{instance_name}]"
    end
  end
end
