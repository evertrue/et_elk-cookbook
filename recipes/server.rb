[
  'et_elk::default',
  'elk_elasticsearch',
  'elk_logstash::certs',
  'elk_logstash',
  'elk_kibana',
  'et_elk::server_config'
].each { |cb| include_recipe cb }
