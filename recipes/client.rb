servers = search(
  :node,
  node['elk']['logstash_search_str'] +
  " AND chef_environment:#{node.chef_environment}"
).map do |node|
  "#{node['fqdn']}:5043"
end

# We set the list of servers if they have changed
if node['elk_forwarder']['config']['network']['servers'].sort != servers.sort
  # Shuffle up the list so that we have a semi even distribution of load
  node.set['elk_forwarder']['config']['network']['servers'] = servers.shuffle
end

include_recipe 'elk_forwarder::certs'

include_recipe 'elk_forwarder::default'
