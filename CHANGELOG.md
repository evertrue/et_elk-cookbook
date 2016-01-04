# Change Log for et_elk
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased][unreleased]
### Changed

## [3.0.2] - 2016-01-04
## Changed
- Use node.name for x_processed_by field when node fqdn is not available

## [3.0.1] - 2015-12-23
## Changed
- Add logstash curator cron job

## [3.0.0] - 2015-12-22
## Changed
- Cookbook functionality
    + Move to Java 8
    + Remove "client" functionality completely
    + Move most "server_config" content (filters, patterns, etc) to `evertrue/logserver-cookbook`
    + Merge in `evertrue/elk_elasticsearch-cookbook`, `evertrue/elk_logstash-cookbook`, and `evertrue/elk_kibana-cookbook`
    + Move key/cert configuration to `evertrue/logserver-cookbook`
    + Drop `kibana` recipe in favor of directly including `kibana_lwrp::install`
    + Stop using default recipe just to install dependencies
    + Give elasticsearch recipe its own attributes file
    + Move kibana attributes to `server`
    + Clean up the recipe headers
    + Remove blank/false attributes from server attributes file
    + Use underscores instead of spaces for ssl-related keys
    + Move attributes affecting logstash filter files into their own namespace for easy parsing
    + Set lumberjack default codec to "plain" to match what we are using in prod
    + Automatically include x_input_processor tag in all inputs
    + Clean up a lot of useless attributes
    + Remove resources that do nothing from logstash recipe
    + Move inputs/outputs definition to this cookbook (from `evertrue/logserver-cookbook`)
    + Craft a helper method (`generate_module_config`) to simplify the rendering of the input/output templates
    + Upgrade `elasticsearch` cookbook to version 2 (and associated cookbook changes)
    + Upgrade `kibana` to v4.3.0
    + Use less specific version for kibana_lwrp cookbook
- Test functionality
    + Modernize TravisCI config
    + Substantially clean up and improve the integration tests
    + Remove Rubygems stuff completely (deprecated in favor of ChefDK)
    + Remove unused default instace from Travis tests
    + ServerSpec tests: Use net/http+JSON instead of cURL to parse ES status response

## [2.3.3] - 2015-10-15
## Changed
- Add a Java-type timestamp matcher to the java log filter

## [2.3.2] - 2015-10-15
## Changed
- Set flag x_input_processor on all inputs

## 

## [2.3.1] - 2015-10-15
## Changed
- Add service restart notifications to logstash_config resource calls

## [2.3.0] - 2015-10-15
## Added
- Add log4j input for logstash

## [2.2.0] - 2015-10-08
## Added
- A rails_basic filter handler for handling basic rails logs without fancy multiline parsing

## [2.1.1] - 2015-10-05
## Added
- Attributes describing the plugins required for the logstash configs in et_elk

## [2.1.0] - 2015-09-18
## Changed
- Version pins for elk_elasticsearch and elk_logstash

## Added
- Added sidekiq log proccessing support for events with the tag `sidekiq`

## [2.0.0] - 2015-08-10
### Changed
- Changed the name `elk` -> `et_elk`
- Match multiline log entries correctly
- Clean up a bunch of recipe code
- Spin off a new recipe from `default` called `server` (and its sub-recipe `server_config`)
- Add a bunch of new ServerSpec tests
- Avoid using storage cookbook w/ Vagrant
- Update kitchen-ec2 config as per deprecations
- Avoid the use of custom timestamp parsers
- Drop support for 12.04
- Change test environment name from _default to dev

## [1.3.5] - 2015-08-07
### Added
- Java App Patterns and Filters

## [1.3.4] - 2015-07-01
### Changed
- Specify that the multiline filter should send lines to the previous event

## [1.3.3] - 2015-07-01
### Changed
- Added extra patterns to attempt to match mesos timestamps
- Parse and Remove the `timestamp` field for syslog events
- Add Multiline support for singularity

## [1.3.2] - 2015-06-29
### Changed
- Removed .conf from template names

## [1.3.1] - 2015-06-29
### Changed
- The namespace for logstash input, filter, and output configuration attributes from elk_logstash to just elk

## [1.3.0] - 2015-06-29
### Added
- The inputs, outputs, and syslog filter moved from the `elk_logstash` cookbook

## [1.2.5] - 2015-06-26
### Added
- A common filter to perform a geoip lookup if a `client_ip` field is present
- Instructions and guidlines for adding new patterns to evertrue_patterns

### Changed
- The raw timestamp field from `mesos_timestamp` to just `timestamp` as it is the primary time for that log
- Removed year, month, day, hour, minute, second, and timezone fields as they aren't useful when the timestamp is parsed into a searchable date
- Major cleanup of the schema.  Lots of renaming of fields.

## [1.2.4] - 2015-06-26
### Changed
- Quoted ISO8601 to make configuration valid

## [1.2.3] - 2015-06-26
### Changed
- Used `or` instead of `||` in mesos slave filter

## [1.2.2] - 2015-06-25
### Added
- Filters to parse and remove the `timestamp` fied for haproxy and rails apps into `@timestamp`

## [1.2.1] - 2015-06-25
### Changed
- Add logstash_config resource for mesos filters

## [1.2.0] - 2015-06-24
### Added
- Test Kitchen role and attributes to converge a working All in One box
- Initial Patterns and Filters for Mesos and Singlularity
- Fauxhai to mock ohai data
- date filter to NGINX logs

## [1.1.1] - 2015-06-23
### Changed
- Updated the ET_NGINXERROR pattern to properly match error logs

## [1.1.0] - 2015-06-22
### Added
- NGINX log parsing configuration

## [1.0.7] - 2015-06-18
### Added
- Fixes templates cookbook for evertrue patterns

## [1.0.6] - 2015-06-18
### Added
- Add HAPROXY config

## [1.0.5] - 2015-06-17
### Changed
- Loosen format of view and activerecord timing.

## [1.0.4] - 2015-06-17
### Changed
- The multiline filter's match pattern to accomodate logs with timestamp prefixed lines

## [1.0.3] - 2015-06-17
### Added
- SSL Certificate discovery attributes to find the CA cert

### Changed
- Fixed the rails app filter

## [1.0.2] - 2015-06-15
### Added
- A Fixup to wipe the elk_forwarder namespace if ['elk_forwarder']['config']['files'] is an array not the new format which is a hash

## [1.0.1] - 2015-06-15
### Changed
- Updated to elk_forwarder v2.0

## [1.0.0] - 2015-06-15
### Added
- Rails App log filter and pattern

### Changed

### Removed

## 0.0.1 - YYYY-MM-DD
### Added
- Initial Release



[unreleased]: https://github.com/evertrue/elk-cookbook/compare/v1.3.5...HEAD
[1.3.5]: https://github.com/evertrue/elk-cookbook/compare/v1.3.4...v1.3.5
[1.3.4]: https://github.com/evertrue/elk-cookbook/compare/v1.3.3...v1.3.4
[1.3.3]: https://github.com/evertrue/elk-cookbook/compare/v1.3.2...v1.3.3
[1.3.2]: https://github.com/evertrue/elk-cookbook/compare/v1.3.1...v1.3.2
[1.3.1]: https://github.com/evertrue/elk-cookbook/compare/v1.3.0...v1.3.1
[1.3.0]: https://github.com/evertrue/elk-cookbook/compare/v1.2.5...v1.3.0
[1.2.5]: https://github.com/evertrue/elk-cookbook/compare/v1.2.4...v1.2.5
[1.2.4]: https://github.com/evertrue/elk-cookbook/compare/v1.2.3...v1.2.4
[1.2.3]: https://github.com/evertrue/elk-cookbook/compare/v1.2.2...v1.2.3
[1.2.2]: https://github.com/evertrue/elk-cookbook/compare/v1.2.1...v1.2.2
[1.2.1]: https://github.com/evertrue/elk-cookbook/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/evertrue/elk-cookbook/compare/v1.1.1...v1.2.0
[1.1.1]: https://github.com/evertrue/elk-cookbook/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/evertrue/elk-cookbook/compare/v1.0.7...v1.1.0
[1.0.7]: https://github.com/evertrue/elk-cookbook/compare/v1.0.6...v1.0.7
[1.0.6]: https://github.com/evertrue/elk-cookbook/compare/v1.0.5...v1.0.6
[1.0.5]: https://github.com/evertrue/elk-cookbook/compare/v1.0.4...v1.0.5
[1.0.4]: https://github.com/evertrue/elk-cookbook/compare/v1.0.3...v1.0.4
[1.0.3]: https://github.com/evertrue/elk-cookbook/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/evertrue/elk-cookbook/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/evertrue/elk-cookbook/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/evertrue/elk-cookbook/compare/v0.0.1...v1.0.0
