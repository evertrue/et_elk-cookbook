logstash_pattern 'rails' do
  instance 'server'
  templates_cookbook 'et_rails_app'
  templates 'pattern_rails_app' => 'pattern_rails_app.erb'
end

logstash_config 'rails app filter' do
  templates_cookbook 'elk_logstash'
  templates 'filter_rails_app' => 'filter_rails_app.erb'
  instance 'server'
  variables node['elk_logstash']['server']
end
