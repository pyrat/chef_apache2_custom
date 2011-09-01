#
# Cookbook Name:: github
# Recipe:: apache2_custom::github
#
#
# MIT

# Copy a key to the .ssh directory of the deploy user
# Call this key id_rsa for simple github cloning

user = node[:apache_custom][:app_user]
user_group = node[:apache_custom][:app_group]

# Could potentially use an encryted databag item here.
github_creds = Chef::DataBagItem.load("githubs", "default")
id_rsa = github_creds["private_key"]

file "/home/#{user}/.ssh/id_rsa" do
  owner user
  group user_group
  mode 0600
  action :create
  content id_rsa
  not_if do
    File.exists?("/home/#{user}/.ssh/id_rsa")
  end
end