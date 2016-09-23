name             'et_elk'
maintainer       'EverTrue, inc.'
maintainer_email 'eddie.hurtig@evertrue.com'
license          'apache2'
description      'Configures an Elk Cluster'
long_description 'Installs/Configures elk'
version          '6.0.0'

supports 'ubuntu', '>= 14.04'

depends 'java', '~> 1.0'
depends 'runit', '~> 1.5'
depends 'cron'

depends 'elasticsearch', '= 2.3.1'
depends 'storage', '~> 5.0'

depends 'kibana_lwrp', '~> 3.0'
