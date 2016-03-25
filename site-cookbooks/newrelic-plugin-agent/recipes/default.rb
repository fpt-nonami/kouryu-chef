#
# Cookbook Name:: newrelic-plugin-agent
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

script "install" do
  interpreter "bash"
  user "root"
  code <<-EOL
    pip install newrelic-plugin-agent
    pip install newrelic-plugin-agent[mongodb]
    cp /opt/newrelic-plugin-agent/newrelic-plugin-agent.rhel /etc/rc.d/init.d/newrelic-plugin-agent
    chmod 0755 /etc/rc.d/init.d/newrelic-plugin-agent
  EOL
  not_if {File.exists?("/opt/newrelic-plugin-agent/newrelic-plugin-agent.rhel")}
end.

template "newrelic-plugin-agent.cfg" do
  path "/etc/newrelic/newrelic-plugin-agent.cfg"
  source "newrelic-plugin-agent.cfg.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
      :license_key           => node['newrelic']['license_key'],
      :hostname              => node['hostname'],
      :mongodb               => node['newrelic-plugin-agent']['mongodb'],
      :mongodb_database_name => node['newrelic-plugin-agent']['mongodb_database_name'],
      :redis                 => node['newrelic-plugin-agent']['redis']
  )
end

link "/usr/bin/newrelic-plugin-agent" do
  to "/usr/local/bin/newrelic-plugin-agent"
end

service 'newrelic-plugin-agent' do
  action [ :enable, :start ]
end
