# Update/remove this
default['elk_kibana']['cluster']['name'] = "#{node.chef_environment}-elk"

set['java']['jdk_version'] = 8

set['kibana']['version'] = '4.1.1-linux-x64'
set['kibana']['file']['url'] = 'https://download.elasticsearch.org/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz'

default['et_elk']['server']['elasticsearch']['cluster'] = "#{node.chef_environment}-elk"
default['et_elk']['server']['elasticsearch']['embedded'] = false
default['et_elk']['server']['elasticsearch']['protocol'] = 'http'

default['et_elk']['server']['lumberjack']['ssl certificate'] =
  '/etc/logstash/lumberjack.crt.pem'
default['et_elk']['server']['lumberjack']['ssl key'] = '/etc/logstash/lumberjack.key.pem'
default['et_elk']['server']['lumberjack']['host'] = '0.0.0.0'
default['et_elk']['server']['lumberjack']['port'] = '5043'
default['et_elk']['server']['lumberjack']['codec'] = 'json'
default['et_elk']['server']['lumberjack']['add_field']['x_proccessed_by'] = node['fqdn']
default['et_elk']['server']['lumberjack']['add_field']['x_proccessor_chef_env'] =
  node.chef_environment

default['et_elk']['server']['log4j']['data_timeout'] = 5
default['et_elk']['server']['log4j']['host'] = '0.0.0.0'
default['et_elk']['server']['log4j']['mode'] = 'server'
default['et_elk']['server']['log4j']['port'] = 5044

default['et_elk']['server']['file']['path'] = '/var/log/logstash-output.log'
default['et_elk']['server']['file']['codec'] = 'rubydebug'

set['elk_logstash']['plugins'] = %w(
  logstash-filter-alter
)
