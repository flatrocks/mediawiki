#
# Cookbook Name:: mediawiki
# Recipe:: mysql
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'database::mysql'
# include_recipe 'mysql::client'
# package 'libmysqlclient-dev'
# chef_gem 'mysql'

mysql_service 'default' do
  allow_remote_root false
  remove_anonymous_users true
  remove_test_database true
  server_root_password 'password123'
  action :create
end

mysql_db_info = {
  :host => 'localhost',
  :username => 'root',
  :password => 'password123'
}

mysql_database 'wiki' do
  connection mysql_db_info
  action :create
end

mysql_database_user 'wiki_user' do
  connection mysql_db_info
  password 'wiki_pass'
  action :create
end

mysql_database_user 'wiki_user' do
  connection mysql_db_info
  database_name 'wiki'
  host 'localhost'
  privileges [:all]
  action :grant
end
