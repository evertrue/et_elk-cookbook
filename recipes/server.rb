############
# Patterns #
############
logstash_pattern 'evertrue patterns' do
  templates_cookbook 'elk'
  templates 'evertrue_patterns' => 'evertrue_patterns.erb'
  instance 'server'
  variables node['elk']['server']
end

############
#  Inputs  #
############
logstash_config 'lumberjack input' do
  templates_cookbook 'elk'
  templates 'input_lumberjack' => 'input_lumberjack.erb'
  instance 'server'
  variables node['elk']['server']
end

############
# Filters  #
############
logstash_config 'common filter' do
  templates_cookbook 'elk'
  templates 'filter_000_common' => 'filter_common.erb'
  instance 'server'
  variables node['elk']['server']
end

logstash_config 'syslog filter' do
  templates_cookbook 'elk'
  templates 'filter_syslog' => 'filter_syslog.erb'
  instance 'server'
  variables node['elk']['server']
end

logstash_config 'rails app filter' do
  templates_cookbook 'elk'
  templates 'filter_rails_app' => 'filter_rails_app.erb'
  instance 'server'
  variables node['elk']['server']
end

logstash_config 'haproxy http filter' do
  templates_cookbook 'elk'
  templates 'filter_haproxy_http' => 'filter_haproxy_http.erb'
  instance 'server'
  variables node['elk']['server']
end

logstash_config 'nginx filters' do
  templates_cookbook 'elk'
  templates 'filter_nginx' => 'filter_nginx.erb'
  instance 'server'
  variables node['elk']['server']
end

logstash_config 'mesos filters' do
  templates_cookbook 'elk'
  templates 'filter_mesos' => 'filter_mesos.erb'
  instance 'server'
  variables node['elk']['server']
end

############
# Outputs  #
############
logstash_config 'elasticsearch output' do
  templates_cookbook 'elk'
  templates 'output_elasticsearch' => 'output_elasticsearch.erb'
  instance 'server'
  variables node['elk']['server']
end
