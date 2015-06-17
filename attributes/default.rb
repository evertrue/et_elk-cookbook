default['elk']['logstash_search_str'] = 'recipes:elk_logstash\:\:default'

# Wipe legacy format of files
if node['elk_forwarder']['config']['files'].is_a?(Array)
  node.rm('elk_forwarder', 'config', 'files')
end

set['elk_forwarder']['config']['files']['syslog']['paths'] = ['/var/log/syslog']
set['elk_forwarder']['config']['files']['syslog']['fields']['type'] = 'syslog'
