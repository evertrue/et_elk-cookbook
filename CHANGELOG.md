# Change Log for elk
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased][unreleased]
### Changed

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
[1.0.0]: https://github.com/evertrue/elk-cookbook/compare/v0.0.1...v1.0.0
