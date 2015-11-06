[
  'et_elk::default',
  'et_elk::elasticsearch',
  'et_elk::logstash',
  'et_elk::kibana'
].each { |cb| include_recipe cb }
