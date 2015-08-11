# ELK [![Build Status](https://travis-ci.org/evertrue/et_elk-cookbook.svg)](https://travis-ci.org/evertrue/et_elk-cookbook)

![ELK](http://www.bogotobogo.com/Hadoop/ELK/images/ELK_Icon.png)

This cookbook is the top level wrapper for the EverTrue ELK cookbook ecosystem

# Requirements

* `et_elk` Ties all the peices of an ELK cluster together
  * `elk_forwarder` Installs and Configures Logstash forwarder
  * `elk_logstash` Installs and Configures a central Logstash server
    * Leverages the `logstash` cookbook
  * `elk_elasticsearch` Installs and Configures an optimized Elasticsearch for use with Logstash
    * Leverages the `elasticsearch` cookbook
  * `elk_kibana` Installs and Configures Kibana for visualizing logs
    * Leverages the `kibana` cookbook

# How do I actually use this system

## 1. Forwarders

You need to apply the `client` recipe to all your nodes.  This will install and configure the Logstash Forwarder using `elk_forwarder`

## 2. Configure Forwarders

You then need to determine what logs you want to forward and you need to come up with a unique "type" to identify them.  I.E. logs from rails app log files will have their type field set to `rails_app`.

From your Attributes

```ruby
set['elk_forwarder']['config']['files']['myapp']['paths'] = ['/var/log/myapp.log']
set['elk_forwarder']['config']['files']['myapp']['fields']['type'] = 'myapp'
set['elk_forwarder']['config']['files']['myapp']['fields']['foo'] = 'bar'
```

Or from your recipe. This one loops through a list of apps

```ruby
apps.each do |app|
  node.set['elk_forwarder']['config']['files']['myapp']['paths'] = ["/var/log/#{app}.log"]
  node.set['elk_forwarder']['config']['files']['myapp']['fields']['type'] = app
  node.set['elk_forwarder']['config']['files']['myapp']['fields']['foo'] = 'bar'
end
```

## 3. Write your pattern

We need to build a pattern(s) to add to [evertrue_patterns.erb](https://github.com/evertrue/et_elk-cookbook/blob/master/templates/default/evertrue_patterns.erb) or another patterns template that you have setup. Grab a bunch of sample logs and use the [Grok Constructor](http://grokconstructor.appspot.com/) utility to construct a pattern that will match your logs.  I usually find an existing pattern online and then tweak it to properly match the logs I am parsing.

Give your pattern a name like `ET_PUPPIES_APP` and add it to your patterns template.

## 4. Write your filter

This is pretty open ended, but here are the key requirements.

* Checks the log's type field with an `if` condition
* Groks the log with the pattern you just created
* Parses a field containing some gross timestamp into the standard `@timestamp` field using the `date` filter.  Note that the `timestamp` field is very different from `@timestamp`. `timestamp` is just a string extracted from the log which needs to be converted into a nice date/time.

Example:

```ruby
filter {
  if [type] == "nginx_access" {
    grok {
      match => ["message", "%{ET_NGINXACCESS}"]
    }

    date {
      match => [ "timestamp", "dd/MMM/YYYY:HH:mm:ss Z" ]
      remove_field => [ "timestamp" ]
    }
  }
}
```

Once you have written your filter, save it to a new template and call the `logstash_config` resource with something like this in your cookbook's recipe

```ruby
logstash_config 'nginx filter' do
  templates_cookbook 'yourcookbook'
  templates 'filter_nginx' => 'filter_nginx.erb'
  instance 'server'
end
```

And now you are shipping, recieving, groking, parsing, inspecting, mutating, indexing, and storing your logs!

# Recipes

## default

Installs everything on the node and configures it to be a central log server that recieves logs from the clients

1. Install Elasticsearch, Logstash, and kibana
2. Configure logstash with inputs and outputs using `elk::server`

## client

Configures the node to be a client that ships logs to the central logstash server

1. Install logstash-forwarder via `elk_forwarder`
2. Configure logstash-forwarder to forward logs to central log servers
    * Central logstash servers are discovered via the `node['et_elk']['logstash_discovery']` attribute
    * To Disable auto-discovery simply set `node['et_elk']['logstash_discovery']` to `''`

# Usage


```ruby
depends 'et_elk', '~> 1.0'
```

```ruby
# To install and configure the forwarder

include_recipe 'et_elk::client'

# To install everything on the node

include_recipe 'et_elk::default'
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
