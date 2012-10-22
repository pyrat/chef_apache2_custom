#
# Cookbook Name:: apache2_custom
# Recipe:: default
#
#
# MIT
#

directory node[:apache_custom][:app_dir] do
  owner node[:apache_custom][:app_user]
  group node[:apache_custom][:app_group]
  mode "0775"
  action :create
  recursive true
  not_if do
    File.directory?(node[:apache_custom][:app_dir])
  end
end

execute "groups apache" do
  command "usermod -a -G #{node[:apache_custom][:apache_group]} #{node[:apache_custom][:app_group]}"
end

execute "groups app" do
  command "usermod -a -G #{node[:apache_custom][:app_group]} #{node[:apache_custom][:apache_group]}"
end

execute "disable the default apache configuration" do
  command "a2dissite 000-default;/etc/init.d/apache2 reload"
  user 'root'
end