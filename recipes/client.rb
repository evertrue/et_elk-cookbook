servers = search(
  :node,
  node['elk']['logstash_search_str'] +
  " AND chef_environment:#{node.chef_environment}"
).map do |node|
  "#{node['fqdn']}:5043"
end

node.set['elk_forwarder']['config']['network']['servers'] = servers

include_recipe 'elk_forwarder::certs'

elk_forwarder_log 'syslog' do
  paths [
    '/var/log/syslog'
  ]
  fields type: :syslog
end

include_recipe 'elk_forwarder::default'
