default['et_elk']['server']['config']['output']['elasticsearch']['hosts'] = '127.0.0.1'

default['et_elk']['server']['config']['input']['beats']['ssl'] = true
default['et_elk']['server']['config']['input']['beats']['ssl_certificate'] =
  '/etc/logstash/lumberjack.crt.pem'
default['et_elk']['server']['config']['input']['beats']['ssl_key'] =
  '/etc/logstash/lumberjack.key.pem'
default['et_elk']['server']['config']['input']['beats']['host'] = '0.0.0.0'
default['et_elk']['server']['config']['input']['beats']['port'] = 5043
default['et_elk']['server']['config']['input']['beats']['codec'] = 'plain'
default['et_elk']['server']['config']['input']['beats']['add_field']['x_proccessed_by'] =
  node['fqdn'] || node.name
default['et_elk']['server']['config']['input']['beats']['add_field']['x_proccessor_chef_env'] =
  node.chef_environment

default['et_elk']['server']['config']['input']['log4j']['data_timeout'] = 5
default['et_elk']['server']['config']['input']['log4j']['host'] = '0.0.0.0'
default['et_elk']['server']['config']['input']['log4j']['mode'] = 'server'
default['et_elk']['server']['config']['input']['log4j']['port'] = 5044

# All input processors should leave tags indicating their names
default['et_elk']['server']['config']['input'].each_key do |input|
  default['et_elk']['server']['config']['input'][input]['add_field']['x_input_processor'] = input
end

default['et_elk']['logstash']['plugins'] = %w(logstash-filter-alter logstash-input-beats)
default['et_elk']['logstash']['version'] = '1:5.2.2-1'
default['et_elk']['logstash']['index_cleanup_days'] = 30
