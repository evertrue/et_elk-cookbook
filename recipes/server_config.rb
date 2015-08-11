cookbook_name = 'et_elk'
node.set['logstash']['instance']['server']['config_templates_cookbook'] =
  cookbook_name

############
# Patterns #
############
logstash_pattern 'evertrue patterns' do
  templates 'evertrue_patterns' => 'evertrue_patterns.erb'
  instance 'server'
end

############
#  Inputs  #
############
logstash_config 'lumberjack input' do
  templates 'input_lumberjack' => 'input_lumberjack.erb'
  instance 'server'
  variables node['et_elk']['server']
end

############
# Filters  #
############
logstash_config 'common filter' do
  templates 'filter_000_common' => 'filter_common.erb'
  instance 'server'
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
    templates "filter_#{app}" => "filter_#{app}.erb"
    instance 'server'
  end
end

############
# Outputs  #
############
logstash_config 'elasticsearch output' do
  templates 'output_elasticsearch' => 'output_elasticsearch.erb'
  instance 'server'
  variables node['et_elk']['server']
end
