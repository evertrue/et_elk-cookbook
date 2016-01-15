#
# Cookbook Name:: et_elk
# Recipe:: logstash
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.

apt_repository 'logstash' do
  uri 'http://packages.elastic.co/logstash/2.1/debian'
  distribution node['lsb_codename']
  components %w(stable main)
  deb_src false
  key 'https://packages.elastic.co/GPG-KEY-elasticsearch'
  notifies :run, 'execute[apt-get update]', :immediately
end

package 'logstash' do
  version node['et_elk']['logstash']['version']
end

###########
# Plugins #
###########
node['et_elk']['logstash']['plugins'].each do |plugin|
  execute "install logstash plugin #{plugin}" do
    command "/opt/logstash/bin/plugin install #{plugin}"
    not_if "/opt/logstash/bin/plugin list #{plugin}"
  end
end

service 'logstash' do
  supports status: true, restart: true
  action %i(enable start)
end

####################
#  Inputs/Outputs  #
####################
node['et_elk']['server']['config'].each do |type, type_conf|
  type_conf.each do |module_name, module_conf|
    template "/etc/logstash/conf.d/#{type}_#{module_name}" do
      source 'filter.erb'
      owner 'logstash'
      group 'logstash'
      variables(
        type: type,
        module_name: module_name,
        module_conf: ::EtElk::Helpers.generate_module_config(module_conf, 4)
      )
      notifies :restart, 'service[logstash]'
    end
  end
end

# Remove vestigial config files
%w(input output).each do |type|
  Dir.glob("/etc/logstash/conf.d/#{type}_*").each do |dir_entry|
    module_name = File.basename(dir_entry).sub("#{type}_", '')
    file dir_entry do
      action :delete
      notifies :restart, 'service[logstash]'
      not_if { node['et_elk']['server']['config'].fetch(type, {})[module_name] }
    end
  end
end
