default['elk']['server']['elasticsearch']['host'] = ''
default['elk']['server']['elasticsearch']['port'] = ''
default['elk']['server']['elasticsearch']['cluster'] = "#{node.chef_environment}-elk"
default['elk']['server']['elasticsearch']['embedded'] = false
default['elk']['server']['elasticsearch']['bind_host'] = ''
default['elk']['server']['elasticsearch']['index'] = ''
default['elk']['server']['elasticsearch']['protocol'] = 'http'

default['elk']['server']['lumberjack']['ssl certificate'] =
  '/etc/logstash/lumberjack.crt.pem'
default['elk']['server']['lumberjack']['ssl key'] = '/etc/logstash/lumberjack.key.pem'
default['elk']['server']['lumberjack']['host'] = '0.0.0.0'
default['elk']['server']['lumberjack']['port'] = '5043'
default['elk']['server']['lumberjack']['codec'] = 'json'
default['elk']['server']['lumberjack']['add_field']['x_proccessed_by'] = node['fqdn']
default['elk']['server']['lumberjack']['add_field']['x_proccessor_chef_env'] =
  node.chef_environment

default['elk']['server']['file']['path'] = '/var/log/logstash-output.log'
default['elk']['server']['file']['codec'] = 'rubydebug'
