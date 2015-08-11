require 'spec_helper'

describe 'et_elk::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  describe command('/opt/logstash/server/bin/logstash -f /opt/logstash/server/etc/conf.d/ --configtest') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match(/Configuration OK/) }
  end
end
