#
# Cookbook Name:: elk
# Recipe:: default
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

include_recipe 'elk_elasticsearch'

include_recipe 'elk_logstash::certs'

include_recipe 'elk_logstash'

include_recipe 'elk_logstash::configure'

include_recipe 'elk_kibana'

include_recipe 'elk::client'
