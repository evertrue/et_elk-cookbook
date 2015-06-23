# ELK [![Build Status](https://travis-ci.org/evertrue/elk-cookbook.svg)](https://travis-ci.org/evertrue/elk-cookbook)

![ELK](http://www.bogotobogo.com/Hadoop/ELK/images/ELK_Icon.png)

This cookbook is the top level wrapper for the EverTrue ELK cookbook ecosystem

# Requirements

* `elk` Ties all the peices of an elk cluster together
  * `elk_forwarder` Installs and Configures Logstash forwarder
  * `elk_logstash` Installs and Configures a central Logstash server
    * Leverages the `logstash` cookbook
  * `elk_elasticsearch` Installs and Configures an optimized Elasticsearch for use with Logstash
    * Leverages the `elasticsearch` cookbook
  * `elk_kibana` Installs and Configures Kibana for visualizing logs
    * Leverages the `kibana` cookbook

# Recipes

## default

Installs everything on the node and configures it to be a central log server that recieves logs from the clients

1. Install Elasticsearch, Logstash, and kibana
2. Configure logstash with inputs and outputs using `elk::server`

## client

Configures the node to be a client that ships logs to the central logstash server

1. Install logstash-forwarder via `elk_forwarder`
2. Configure logstash-forwarder to forward logs to central log servers
    * Central logstash servers are discovered via the `node['elk']['logstash_discovery']` attribute
    * To Disable auto-discovery simply set `node['elk']['logstash_discovery']` to `''`

# Usage


```ruby
depends 'elk', '~> 1.0'
```

```ruby
# To install and configure the forwarder

include_recipe 'elk::client'

# To install everything on the node

include_recipe 'elk::default'
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests with `kitchen test`, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Author:: EverTrue, inc. (eddie.hurtig@evertrue.com)
