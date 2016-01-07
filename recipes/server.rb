#
# Cookbook Name:: et_elk
# Recipe:: server
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.

[
  'et_elk::elasticsearch',
  'et_elk::logstash',
  'et_elk::kibana'
].each { |cb| include_recipe cb }
