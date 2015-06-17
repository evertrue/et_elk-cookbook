servers = search(
  :node,
  node['elk']['logstash_search_str'] +
  " AND chef_environment:#{node.chef_environment}"
).map do |node|
  "#{node['fqdn']}:5043"
end

# Wipe legacy format of files
if node['elk_forwarder']['config']['files'].is_a?(Array)
  node.rm('elk_forwarder', 'config', 'files')
  return
end

node.set['elk_forwarder']['config']['network']['servers'] = servers

include_recipe 'elk_forwarder::certs'

include_recipe 'elk_forwarder::default'
