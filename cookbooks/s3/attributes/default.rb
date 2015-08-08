#
# Cookbook Name:: s3
# Attribute:: default
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

default['s3']['user'] = "root"
default['s3']['group'] = "root"
default['s3']['target_location'] = "/var/chef/cache"
default['s3']['region'] = "us-east-1"
default['s3']['s3_bucket'] = "artifacts"
default['s3']['s3_file'] = "local.json"
default['s3']['checksum'] = "fcecfd509a9d87fd4e0ebf50ac0b77c06c122d35bf0e4af0582c89118e542a8d"
default['s3']['aws_access_key'] = ""
default['s3']['aws_secret_access_key'] = ""