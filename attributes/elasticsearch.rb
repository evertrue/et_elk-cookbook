default['et_elk']['elasticsearch']['plugins']['hq']['url'] = 'royrusso/elasticsearch-HQ'
default['et_elk']['elasticsearch']['plugins']['head']['url'] = 'mobz/elasticsearch-head'
default['et_elk']['elasticsearch']['plugins']['cloud-aws'] = {}
default['et_elk']['elasticsearch']['custom_config'] = {
  'cloud.node.auto_attributes' => true,
  'cluster.name' => "#{node.chef_environment}-elk",
  'network.host' => '0.0.0.0',
  'index.number_of_shards' => 3,
  'index.search.slowlog.threshold.query.debug' => '1s',
  'index.search.slowlog.threshold.query.warn' => '5s',
  'indices.memory.index_buffer_size' => '50%',
  'indices.breaker.fielddata.limit' => '65%',
  'indices.fielddata.cache.size' => '55%',
  'index.translog.flush_threshold_ops' => 50_000,
  'node.data' => true
}
default['et_elk']['elasticsearch']['search_query'] =
  'recipes:et_elk\:\:server AND ' \
  "chef_environment:#{node.chef_environment} AND " \
  'et_elk_elasticsearch_custom_config_cluster.name:' \
  "#{node['et_elk']['elasticsearch']['custom_config']['cluster.name']} AND " \
  'roles:es_master'
default['et_elk']['storage_type'] = 'ebs'
