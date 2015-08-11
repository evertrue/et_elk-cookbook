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

[
  'syslog',
  'rails app',
  'java',
  'haproxy http',
  'nginx',
  'mesos'
].each do |app|
  logstash_config "#{app} filter" do
    templates_cookbook 'elk'
    templates "filter_#{app}" => "filter_#{app}.erb"
    instance 'server'
    variables node['elk']['server']
  end
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
