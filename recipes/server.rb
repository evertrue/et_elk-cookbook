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
