name             'et_elk'
maintainer       'EverTrue, inc.'
maintainer_email 'devops+cookbooks@evertrue.com'
license          'apache2'
description      'Configures an Elk Cluster'
long_description 'Installs/Configures elk'
version          '6.1.2'

supports 'ubuntu', '>= 14.04'

depends 'java', '~> 1.0'
depends 'runit', '~> 1.5'
depends 'cron'

depends 'elasticsearch', '= 2.4.0'
depends 'storage', '~> 5.0'

depends 'et_kibana_lwrp', '~> 1.0'
depends 'apt'
