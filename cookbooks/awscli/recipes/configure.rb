#
# Cookbook Name:: awscli
# Recipe:: configure
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

#This configures the AWS cli 
awscli = node['awscli']

directory awscli['aws_home'] do
	owner awscli['user']
	group awscli['group']
	mode 00755
	action :create
end

# Creates Credentials file for AWS with the access key and secret key from the data bag
template awscli['creds_file'] do
	source "credentials.erb"
	owner awscli['user']
	group awscli['group']
	mode 00644
	variables({
		:access_key => awscli['aws_access_key_id'],
		:secret_key => awscli['aws_secret_access_key']
	})
end

# Creates config file for AWS with Region
template awscli['config_file'] do
	source "config.erb"
	owner awscli['user']
	group awscli['group']
	mode 00644
	variables({
		:region => awscli['region']
	})
end