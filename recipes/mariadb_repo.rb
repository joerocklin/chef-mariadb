#
# Cookbook Name:: mariadb
# Recipe:: mariadb_repo
#
# Copyright 2012, Myplanet Digital, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

case node['platform_family']
when "debian"
  include_recipe "apt"

  apt_repository "mariadb" do
    uri "http://ftp.osuosl.org/pub/mariadb/repo/#{node[:mariadb][:version]}/debian n"
    distribution node['lsb']['codename']
    components ['main']
    keyserver "keyserver.ubuntu.com"
    key "0xcbcb082a1bb943db"
    action :add
  end

when "rhel", "fedora"
  include_recipe "yum"

  yum_key "mariadb" do
    url "https://yum.mariadb.org/RPM-GPG-KEY-MariaDB"
    action :add
  end

  arch = node['kernel']['machine']
  arch = "x86" unless arch == "amd64"
  pversion = node['platform_version'].split('.').first

  yum_repository "mariadb" do
    description "MariaDB Repository"
    url "http://yum.mariadb.org/#{node[:mariadb][:version]}/#{node[:platform]}#{pversion}-#{arch}"
  end
end
