#
# Cookbook Name:: s3
# Library:: aws_s3
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


module AwsS3
	def s3
		require 'aws-sdk'
		@@s3 ||= create_aws_interface(::Aws::S3::Client)
	end

	private

	def create_aws_interface(aws_interface)       
		require 'aws-sdk'
		creds = ::Aws::Credentials.new(new_resource.aws_access_key, new_resource.aws_secret_access_key)
		::Aws.config[:ssl_verify_peer] = false
		aws_interface.new(credentials: creds, region: new_resource.region)
	end
end