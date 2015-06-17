default['elk']['logstash_search_str'] = 'recipes:elk_logstash\:\:default'

set['elk_forwarder']['config']['files']['syslog']['paths'] = ['/var/log/syslog']
set['elk_forwarder']['config']['files']['syslog']['fields']['type'] = 'syslog'
