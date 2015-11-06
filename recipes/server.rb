[
  'et_elk::default',
  'et_elk::elasticsearch',
  'elk_logstash::certs',
  'elk_logstash',
  'elk_kibana',
].each { |cb| include_recipe cb }
