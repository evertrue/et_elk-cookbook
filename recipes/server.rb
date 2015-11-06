[
  'et_elk::default',
  'elk_elasticsearch',
  'elk_logstash::certs',
  'elk_logstash',
  'elk_kibana',
].each { |cb| include_recipe cb }
