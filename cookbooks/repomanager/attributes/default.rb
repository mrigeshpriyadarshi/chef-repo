#
# Cookbook Name:: repomanager
# Attribute:: default
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

default['repomanager']['repos']['arch'] = node['kernel']['machine'] =~ /x86_64/ ? "x86_64" : "i386"
default['repomanager']['repos']['yumLoc'] = node['platform_version'].to_i < 6 ? "Server" : ""
default['repomanager']['yum']['dir'] ="/etc/yum.repos.d"
default['repomanager']['yum']['url'] = "REDHAT/os/#{node['platform_version']}/#{node['repomanager']['repos']['arch']}/dvd/#{node['repomanager']['repos']['yumLoc']}"
default['repomanager']['yum']['key'] = "RPM-GPG-KEY-redhat-release"
default['repomanager']['yum']['enable'] = "1"
default['repomanager']['zypp']['dir'] ="/etc/zypp/repos.d"
default['repomanager']['zypp']['url'] = "SUSE/os/#{node['platform_version']}/#{node['repomanager']['repos']['arch']}/dvd/"
default['repomanager']['zypp']['enable'] = "1"
default['repomanager']['zypp']['autorefresh'] ="0"