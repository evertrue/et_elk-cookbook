name             'et_elk'
maintainer       'EverTrue, inc.'
maintainer_email 'eddie.hurtig@evertrue.com'
license          'apache2'
description      'Configures an Elk Cluster'
long_description 'Installs/Configures elk'
version          '3.0.1'

supports 'ubuntu', '>= 14.04'

depends 'apt', '~> 2.0'
depends 'java', '~> 1.0'
depends 'runit', '~> 1.5'

depends 'elasticsearch', '~> 2.1'
depends 'storage', '~> 2.2'

depends 'logstash', '~> 0.12.0'

depends 'kibana_lwrp', '~> 2.0'
