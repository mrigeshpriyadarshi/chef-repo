#
# Cookbook Name:: repomanager
# Attribute:: default
#
# Copyright 2014, Mrigesh Priyadarshi
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
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

default['repomanager']['yumservers'] = 	{
						"10.21": [
							"usrepo1",
							"usrepo2"
						],
						"10.22": [
							"sgrepo1",
							"sgrepo2"
						],
						"10.23": [
							"irrepo1",
							"irrepo2"
						],
						"10.24": [
							"eurepo1",
							"eurepo2"
						]
					}