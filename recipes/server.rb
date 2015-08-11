#
# Cookbook Name:: et_elk
# Recipe:: server
#
# Copyright 2015 EverTrue, inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

############
# Patterns #
############
logstash_pattern 'evertrue patterns' do
  templates_cookbook 'et_elk'
  templates 'evertrue_patterns' => 'evertrue_patterns.erb'
  instance 'server'
  variables node['et_elk']['server']
end

############
#  Inputs  #
############
logstash_config 'lumberjack input' do
  templates_cookbook 'et_elk'
  templates 'input_lumberjack' => 'input_lumberjack.erb'
  instance 'server'
  variables node['et_elk']['server']
end

############
# Filters  #
############
logstash_config 'common filter' do
  templates_cookbook 'et_elk'
  templates 'filter_000_common' => 'filter_common.erb'
  instance 'server'
  variables node['et_elk']['server']
end

logstash_config 'syslog filter' do
  templates_cookbook 'et_elk'
  templates 'filter_syslog' => 'filter_syslog.erb'
  instance 'server'
  variables node['et_elk']['server']
end

logstash_config 'rails app filter' do
  templates_cookbook 'et_elk'
  templates 'filter_rails_app' => 'filter_rails_app.erb'
  instance 'server'
  variables node['et_elk']['server']
end

logstash_config 'java filter' do
  templates_cookbook 'et_elk'
  templates 'filter_java' => 'filter_java.erb'
  instance 'server'
  variables node['et_elk']['server']
end

logstash_config 'haproxy http filter' do
  templates_cookbook 'et_elk'
  templates 'filter_haproxy_http' => 'filter_haproxy_http.erb'
  instance 'server'
  variables node['et_elk']['server']
end

logstash_config 'nginx filters' do
  templates_cookbook 'et_elk'
  templates 'filter_nginx' => 'filter_nginx.erb'
  instance 'server'
  variables node['et_elk']['server']
end

logstash_config 'mesos filters' do
  templates_cookbook 'et_elk'
  templates 'filter_mesos' => 'filter_mesos.erb'
  instance 'server'
  variables node['et_elk']['server']
end

############
# Outputs  #
############
logstash_config 'elasticsearch output' do
  templates_cookbook 'et_elk'
  templates 'output_elasticsearch' => 'output_elasticsearch.erb'
  instance 'server'
  variables node['et_elk']['server']
end
