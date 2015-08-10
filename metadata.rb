name             'elk'
maintainer       'EverTrue, inc.'
maintainer_email 'eddie.hurtig@evertrue.com'
license          'apache2'
description      'Configures an Elk Cluster'
long_description 'Installs/Configures elk'
version          '1.3.5'

supports 'ubuntu', '>= 12.04'

depends 'elk_elasticsearch', '~> 0.1'
depends 'elk_logstash', '~> 0.0'
depends 'elk_kibana', '~> 1.1'
depends 'elk_forwarder', '~> 2.0'
