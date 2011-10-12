#
# Cookbook Name:: apache2_custom
# Recipe:: default_site
#
#
# MIT
#

# This installs a default site, overwriting the standard apache2 default page.

include "apache2"

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

templa

