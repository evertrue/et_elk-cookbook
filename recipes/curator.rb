apt_repository 'curator' do
  uri 'http://packages.elastic.co/curator/3/debian'
  distribution node['lsb_codename']
  components %w(stable main)
  deb_src false
  key 'https://packages.elastic.co/GPG-KEY-elasticsearch'
  notifies :run, 'execute[apt-get update]', :immediately
end

package 'python-elasticsearch-curator'

# Curator job to clean up the old indices
cron_d 'logstash_curator' do
  minute 0
  hour 23
  command '/usr/local/bin/curator delete indices ' \
          '--prefix logstash ' \
          '--timestring %Y.%m.%d ' \
          "--older-than #{node['et_elk']['logstash']['index_cleanup_days']} " \
          '--time-unit days ' \
          '--exclude kibana-int'
end
