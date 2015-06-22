logstash_pattern 'rails' do
  templates_cookbook 'elk'
  instance 'server'
  templates 'pattern_rails_app' => 'pattern_rails_app.erb'
end

logstash_config 'rails app filter' do
  templates_cookbook 'elk'
  templates 'filter_rails_app' => 'filter_rails_app.erb'
  instance 'server'
  variables node['elk_logstash']['server']
end

logstash_config 'haproxy http filter' do
  templates_cookbook 'elk'
  templates 'filter_haproxy_http' => 'filter_haproxy_http.erb'
  instance 'server'
  variables node['elk_logstash']['server']
end

logstash_config 'nginx filters' do
  templates_cookbook 'elk'
  templates 'filter_nginx' => 'filter_nginx.erb'
  instance 'server'
  variables node['elk_logstash']['server']
end

logstash_pattern 'evertrue patterns' do
  templates_cookbook 'elk'
  templates 'evertrue_patterns' => 'evertrue_patterns.erb'
  instance 'server'
  variables node['elk_logstash']['server']
end
