#
# Cookbook Name:: s3
# Recipe:: default
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

s3 = node['s3']

directory s3['target_location'] do
	owner s3['user']
	group s3['group']
	mode 00755
	recursive true
	action :create
end


s3_get "Download a #{s3['s3_file']}" do
	region  s3['region']
	target_location s3['target_location']
	bucket s3['s3_bucket']
	checksum s3['checksum']
	key s3['s3_file']
	aws_access_key s3['aws_access_key']
	aws_secret_access_key s3['aws_secret_access_key']
	action :get
end