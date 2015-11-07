require 'spec_helper'

describe 'et_elk::default' do
  describe 'it installs logstash' do
    describe command('/opt/logstash/server/bin/logstash -V') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match(/logstash 1\.5\.4/) }
    end
  end

  describe 'it installs elasticsearch' do
    describe command('curl http://localhost:9200') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should include '"number" : "1.4.4"' }
    end
    describe command('curl http://localhost:9200') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should include '"status" : 200,' }
    end
  end

  describe 'it installs kibana' do
    describe command('/opt/kibana/current/bin/kibana -V') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should include '4.1.1' }
    end
  end
end
