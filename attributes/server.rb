# Update/remove this
default['elk_kibana']['cluster']['name'] = "#{node.chef_environment}-elk"

set['java']['jdk_version'] = 8

set['kibana']['version'] = '4.1.1-linux-x64'
set['kibana']['file']['url'] = 'https://download.elasticsearch.org/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz'

default['et_elk']['server']['file']['path'] = '/var/log/logstash-output.log'
default['et_elk']['server']['file']['codec'] = 'rubydebug'
