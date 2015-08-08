#
# Cookbook Name:: aws_ec2_keeper
# Recipe:: start_instances
#
# Copyright 2015, Mrigesh Priyadarshi
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

aws = node['aws_ec2_keeper']

aws_ec2_keeper "Start EC2 Instances" do
	region aws['region']
	aws_access_key aws['aws_access_key']
	aws_secret_access_key aws['aws_secret_access_key']
	env_list aws['env_list']
	action :start_instances
end