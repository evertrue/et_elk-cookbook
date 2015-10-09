name             'et_elk'
maintainer       'EverTrue, inc.'
maintainer_email 'eddie.hurtig@evertrue.com'
license          'apache2'
description      'Configures an Elk Cluster'
long_description 'Installs/Configures elk'
version          '2.2.0'

supports 'ubuntu', '>= 14.04'

depends 'elk_elasticsearch', '~> 1.0'
depends 'elk_logstash', '~> 1.0'
depends 'elk_kibana', '~> 1.1'
depends 'elk_forwarder', '~> 2.0'
