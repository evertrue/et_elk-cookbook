[
  'et_elk::default',
  'et_elk::elasticsearch',
  'et_elk::logstash',
  'elk_kibana',
].each { |cb| include_recipe cb }
