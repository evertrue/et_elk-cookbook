# Change Log for elk
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased][unreleased]
### Changed

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

[unreleased]: https://github.com/evertrue/elk-cookbook/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/evertrue/elk-cookbook/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/evertrue/elk-cookbook/compare/v1.0.7...v1.1.0
[1.0.7]: https://github.com/evertrue/elk-cookbook/compare/v1.0.6...v1.0.7
[1.0.6]: https://github.com/evertrue/elk-cookbook/compare/v1.0.5...v1.0.6
[1.0.5]: https://github.com/evertrue/elk-cookbook/compare/v1.0.4...v1.0.5
[1.0.4]: https://github.com/evertrue/elk-cookbook/compare/v1.0.3...v1.0.4
[1.0.3]: https://github.com/evertrue/elk-cookbook/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/evertrue/elk-cookbook/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/evertrue/elk-cookbook/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/evertrue/elk-cookbook/compare/v0.0.1...v1.0.0
