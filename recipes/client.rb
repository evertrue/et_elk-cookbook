#
# Cookbook Name:: et_elk
# Recipe:: client
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

servers = search(
  :node,
  node['et_elk']['logstash_search_str'] +
  " AND chef_environment:#{node.chef_environment}"
).map do |node|
  "#{node['fqdn']}:5043"
end

node.set['elk_forwarder']['config']['network']['servers'] = servers

include_recipe 'elk_forwarder::certs'

include_recipe 'elk_forwarder::default'
