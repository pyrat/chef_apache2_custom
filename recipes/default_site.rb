#
# Cookbook Name:: apache2_custom
# Recipe:: default_site
#
#
# MIT
#

# This installs a default site, overwriting the standard apache2 default page.

include_recipe "apache2"

# copy site to /var/www/apps/default_site
# setup site on sites-available/default_site
# enable site

default_dir = "#{node[:apache_custom][:app_dir]}/default_site"

directory default_dir do
  owner node[:apache_custom][:app_user]
  group node[:apache_custom][:app_group]
  mode "0775"
  action :create
  not_if do
    File.directory?(default_dir)
  end
end

template "#{default_dir}/index.html" do
  action :create_if_missing
  source "index.html.erb"
  owner node[:apache_custom][:app_user]
  group node[:apache_custom][:app_group]
  variables(
  :server_name => node[:apache_custom][:server_name], 
  :image_path => node[:apache_custom][:image_path]
  )
  mode "0775"
end

# Copy assets

%w(body_repeat.jpg style.css default.jpg).each do |asset|
  template "#{default_dir}/#{asset}" do
    action :create_if_missing
    source asset
    owner node[:apache_custom][:app_user]
    group node[:apache_custom][:app_group]
    mode "0775"
  end
end

template "/etc/apache2/sites-available/default_site" do
  action :create_if_missing
  source "vhost.erb"
  owner node[:apache_custom][:app_user]
  group node[:apache_custom][:app_group]
  variables(
  :document_root => default_dir
  )
end

apache_site "default_site"
