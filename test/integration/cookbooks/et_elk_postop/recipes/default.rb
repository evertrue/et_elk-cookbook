# Make sure elasticsearch is actually started
service 'elasticsearch' do
  action :start
end

include_recipe 'et_elk_postop::certs'
