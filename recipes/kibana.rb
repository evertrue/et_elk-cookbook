include_recipe 'kibana_lwrp::install'

service 'kibana'

cookbook_file '/opt/kibana/current/config/kibana.yml' do
  owner 'kibana'
  group 'kibana'
  notifies :restart, 'service[kibana]'
end
