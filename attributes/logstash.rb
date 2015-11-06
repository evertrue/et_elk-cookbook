default['logstash']['plugins'] = []

# All this junk needs to be updated
default['elk_logstash']['certs']['certificate_data_bag'] = 'certificates'
default['elk_logstash']['certs']['certificate_data_bag_item'] = 'logstash'
default['elk_logstash']['certs']['certificate_data_bag_item_key'] = 'server certificate'
default['elk_logstash']['certs']['key_data_bag'] = 'certificates'
default['elk_logstash']['certs']['key_data_bag_item'] = 'logstash'
default['elk_logstash']['certs']['key_data_bag_item_key'] = 'server key'

default['elk']['server']['lumberjack']['ssl certificate'] =
  '/etc/logstash/lumberjack.crt.pem'
default['elk']['server']['lumberjack']['ssl key'] = '/etc/logstash/lumberjack.key.pem'
