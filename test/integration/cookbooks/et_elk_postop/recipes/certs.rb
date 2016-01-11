ssl_object = data_bag_item('certificates', 'logstash')['data']

directory '/etc/logstash' do
  recursive true
end

key = node['et_elk']['server']['config']['input']['beats']['ssl_key']
certificate = node['et_elk']['server']['config']['input']['beats']['ssl_certificate']

file key do
  content "#{ssl_object['key']}\n"
  sensitive true
  user 'logstash'
  group 'logstash'
  mode 0600
  notifies :restart, 'service[logstash]'
end

openssl_x509 certificate do
  common_name node['fqdn']
  org 'Log Server Self Signed'
  org_unit '.'
  country 'US'
  expire 30
  key_file key
  notifies :restart, 'service[logstash]'
  not_if { ::File.exist? certificate } # Necessary because of a bug in openssl_x509
end
