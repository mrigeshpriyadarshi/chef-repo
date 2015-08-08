#
# Cookbook Name:: awscli
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

#Attributes required to configure aws cli
default['awscli']['arch'] = node['kernel']['machine'] =~ /x86_64/ ? "64" : "32"

case node['os']
	when 'linux'
		case node['platform']
			when "redhat", "centos"
				default['awscli']['user'] = "root"
				default['awscli']['group'] = "root"
				default['awscli']['aws_home'] = "/root/.aws"
			when "ubuntu"
				default['awscli']['user'] = "ubuntu"
				default['awscli']['group'] = "ubuntu"
				default['awscli']['aws_home'] = "/root/ubuntu/.aws"
		end
	when 'windows'
		default['awscli']['user'] = "administrator"
		default['awscli']['group'] = "administrator"
		default['awscli']['aws_home'] = "C:\\Users\\#{node['awscli']['user']}\\.aws"
end

# configure Attributes
default['awscli']['aws_access_key_id'] = ""
default['awscli']['aws_secret_access_key'] = ""
default['awscli']['region'] = "us-east-1"
default['awscli']['creds_file'] = "#{node['awscli']['aws_home']}/credentials"
default['awscli']['config_file'] = "#{node['awscli']['aws_home']}/config"


# Windows Attributes
default['awscli']['windows']['installer_download_loc']= "C:\\downloads"
default['awscli']['windows']['installer'] = "AWSCLI#{node['awscli']['arch']}.msi"
default['awscli']['windows']['cli_pckg_url'] = "https://s3.amazonaws.com/aws-cli/#{node['awscli']['windows']['installer']}"
default['awscli']['windows']['install_path'] = "C:\\Amazon\\AWSCLI"