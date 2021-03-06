name             'et_elk'
maintainer       'EverTrue, inc.'
maintainer_email 'devops+cookbooks@evertrue.com'
license          'apache2'
description      'Configures an Elk Cluster'
long_description 'Installs/Configures elk'
version          '6.2.1'

supports 'ubuntu', '>= 14.04'

depends 'java', '~> 1.0'
depends 'runit', '~> 1.5'
depends 'cron'

depends 'elasticsearch', '~> 3.0'
depends 'storage', '~> 6.0'

depends 'et_kibana_lwrp'
depends 'apt'
