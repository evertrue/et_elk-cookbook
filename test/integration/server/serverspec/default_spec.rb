require 'spec_helper'
require 'net/http'
require 'json'

describe 'et_elk::elasticsearch' do
  describe 'it installs elasticsearch' do
    describe file('/usr/share/elasticsearch/bin/elasticsearch') do
      it { should be_executable }
    end
  end

  describe 'elasicsearch is up and healthy' do
    describe service('elasticsearch') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end

    describe 'API response' do
      es_api_response = Net::HTTP.get_response(URI('http://localhost:9200'))

      it 'returns 200 status code' do
        expect(es_api_response.code).to eq '200'
      end

      it 'has the right version' do
        expect(JSON.parse(es_api_response.body)['version']['number']).to eq('2.1.0')
      end
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

  describe command('/opt/logstash/server/bin/logstash -f ' \
                   '/opt/logstash/server/etc/conf.d/ --configtest') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match(/Configuration OK/) }
  end

  describe 'input/output config' do
    describe file('/opt/logstash/server/etc/conf.d/input_lumberjack') do
      it { is_expected.to be_file }
      its(:content) do
        is_expected.to match("input {
  lumberjack {
    ssl_certificate => \"/etc/logstash/lumberjack.crt.pem\"
    ssl_key => \"/etc/logstash/lumberjack.key.pem\"
    host => \"0.0.0.0\"
    port => 5043
    codec => \"plain\"
    add_field => {
      x_proccessed_by => \"#{`hostname -f`.chomp}\"
      x_proccessor_chef_env => \"_default\"
      x_input_processor => \"lumberjack\"
    }
  }
}")
      end
    end

    describe file('/opt/logstash/server/etc/conf.d/input_log4j') do
      it { is_expected.to be_file }
      its(:content) do
        is_expected.to match('input {
  log4j {
    data_timeout => 5
    host => "0.0.0.0"
    mode => "server"
    port => 5044
    add_field => {
      x_input_processor => "log4j"
    }
  }
}')
      end
    end

    describe file('/opt/logstash/server/etc/conf.d/output_elasticsearch') do
      it { is_expected.to be_file }
      its(:content) do
        is_expected.to match('output {
  elasticsearch {
    cluster => "_default-elk"
    embedded => false
    protocol => "http"
  }
}')
      end
    end
  end
end

describe 'et_elk::server' do
  describe 'it installs kibana' do
    describe command('/opt/kibana/current/bin/kibana -V') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should include '4.3.0' }
    end
  end

  describe 'kibana is up' do
    describe service('kibana') do
      it { is_expected.to be_running }
    end

    describe command('curl http://localhost:5601/app/kibana') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should include '<title>Kibana</title>' }
    end
  end
end
