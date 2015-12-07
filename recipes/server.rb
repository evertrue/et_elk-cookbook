[
  'et_elk::elasticsearch',
  'et_elk::logstash',
  'kibana_lwrp::install'
].each { |cb| include_recipe cb }
