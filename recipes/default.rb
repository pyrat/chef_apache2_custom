#
# Cookbook Name:: apache2_custom
# Recipe:: default
#
#
# MIT
#

directory node[:apache_custom][:app_dir] do
  owner default[:apache_custom][:app_user]
  group default[:apache_custom][:app_group]
  mode "0775"
  action :create
end

execute "groups apache" do
  command "usermod -a -G #{default[:apache_custom][:apache_group]} #{default[:apache_custom][:app_group]}"
end

execute "groups app" do
  command "usermod -a -G #{default[:apache_custom][:app_group]} #{default[:apache_custom][:apache_group]}"
end