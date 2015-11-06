
# Install Ruby
package 'ruby'

node.set['java']['java_home']   = '/usr/lib/jvm/java-7-openjdk-amd64'
node.set['java']['java_exec']   = node['java']['java_home'] + '/bin/java'
node.set['java']['jdk_version'] = '7'

include_recipe 'java'

include_recipe 'storage'

node.set['elasticsearch']['version'] = '1.4.4'
node.set['elasticsearch']['cluster']['name'] = "#{node.chef_environment}-elk"

node.set['elasticsearch']['index']['search']['slowlog']['threshold']['query'] = {
  'warn' => '5s',
  'debug' => '1s'
}
node.set['elasticsearch']['discovery'] = {
  'search_query' => 'elasticsearch_cluster_name:' +
                    node['elasticsearch']['cluster']['name'] +
                    ' AND elasticsearch_node.master:true' \
                    " AND chef_environment:#{node.chef_environment}",
  'node_attribute' => nil
}

node.set['elasticsearch']['plugins'] = {
  'royrusso/elasticsearch-HQ'  => {},
  'mobz/elasticsearch-head'    => {},
  'sonian/elasticsearch-jetty' => {
    'url' => 'https://oss-es-plugins.s3.amazonaws.com/elasticsearch-jetty/elasticsearch-jetty-1.2.1.zip'
  },
  'elasticsearch/elasticsearch-cloud-aws' => {
    'version' => '2.4.1'
  }
}

allocated_memory = "#{(node['memory']['total'].to_i * 0.4).floor / 1024}m"
node.set['elasticsearch']['allocated_memory'] = allocated_memory
node.set['elasticsearch']['index_base_key'] = 'default-0'

# this should be moved to the logserver cookbook and replaced with the logserver cookbook in the search_query
node.set['elasticsearch']['discovery']['search_query'] =
  "recipes:et_elk\\:\\:server AND chef_environment:#{node.chef_environment}"

node.set['elasticsearch']['custom_config']['index.number_of_shards'] = 3
node.set['elasticsearch']['custom_config']['indices.memory.index_buffer_size'] = '50%'
node.set['elasticsearch']['custom_config']['index.translog.flush_threshold_ops'] = 50_000

if node['storage']['ephemeral_mounts'] &&
   node['storage']['ephemeral_mounts'].any?
  node.set['elasticsearch']['path']['data'] = node['storage']['ephemeral_mounts'].map do |mount|
    "#{mount}/elasticsearch/data"
  end.sort
end

node.set['elasticsearch']['node.master'] = node['roles'].include?('es_master')
node.set['elasticsearch']['node.data'] = true

include_recipe 'elasticsearch'
include_recipe 'elasticsearch::plugins'
include_recipe 'elasticsearch::search_discovery'
