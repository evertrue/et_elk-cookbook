# These resources need to be run before the logstash.rb recipe tries to gather
# a file listing of /etc/logstash/conf.d using Dir.glob(), which runs during the
# compile phase.

directory '/etc/logstash/conf.d' do
  recursive true
  action :nothing
end.run_action(:create)

cookbook_file 'create /etc/logstash/conf.d/output_deleteme' do
  path '/etc/logstash/conf.d/output_deleteme'
  action :nothing
end.run_action(:create)
