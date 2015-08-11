[
  'et_elk::default',
  'elk_elasticsearch',
  'elk_logstash::certs',
  'elk_logstash',
  'elk_kibana',
  'et_elk::server_config',
  'et_elk::client'
].each { |cb| include_recipe cb }
