require 'spec_helper'

describe 'et_elk::elasticsearch' do
  describe 'it installs elasticsearch' do
    describe file('/usr/local/elasticsearch/bin/elasticsearch') do
      it { should be_owned_by 'elasticsearch' }
      it { should be_grouped_into 'elasticsearch' }
      it { should be_executable }
    end
  end

  describe 'elasicsearch is up and healthy' do
    describe service('elasticsearch') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end

    describe command('curl http://localhost:9200') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should include '"number" : "1.4.4"' }
    end

    describe command('curl http://localhost:9200') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should include '"status" : 200,' }
    end
  end
end

describe 'et_elk::logstash' do
  describe 'it installs logstash' do
    describe command('/opt/logstash/server/bin/logstash -V') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match(/logstash 1\.5\.4/) }
    end
  end

  describe 'logstash is up' do
    describe service('logstash_server') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end
  end
end

describe 'et_elk::kibana' do
  describe 'it installs kibana' do
    describe command('/opt/kibana/current/bin/kibana -V') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should include '4.1.1' }
    end
  end

  describe 'kibana is up' do
    describe service('kibana') do
      it { is_expected.to be_running }
    end

    describe command('curl http://localhost:5601') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should include 'Kibana 4' }
    end
  end
end
