name             'elk'
maintainer       'EverTrue, inc.'
maintainer_email 'eddie.hurtig@evertrue.com'
license          'apache2'
description      'Configures an Elk Cluster'
long_description 'Installs/Configures elk'
version          '1.3.1'

supports 'ubuntu', '>= 12.04'

depends 'elk_elasticsearch'
depends 'elk_logstash'
depends 'elk_kibana'
depends 'elk_forwarder', '~> 2.0'
