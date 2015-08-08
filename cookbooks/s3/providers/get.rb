#
# Cookbook Name:: s3
# Provider:: get
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

include AwsS3
include Chef::Mixin::Checksum

def whyrun_supported?
	true
end

def install_aws_sdk
	Chef::Log.info "Installing Ruby Aws SDK!!"
	chef_gem "aws-sdk" do
		compile_time false if respond_to?(:compile_time)
	end
end

def contents_changed?(tempfile)
	Chef::Log.debug "calculating checksum of #{tempfile} to compare with #{@new_resource.checksum}"
	checksum(tempfile) != @new_resource.checksum
end

def action_create
	converge_by("Downloaded S3 File: #{new_resource.key}") do
		s3.get_object(
			# required
			response_target: @response_target,
			bucket: @new_resource.bucket,
			key: @new_resource.key
		)
		Chef::Log.info("Downloading S3 File: #{new_resource.key}")
	end
end

action :get do
	install_aws_sdk
	@response_target = new_resource.target_location + "/" + new_resource.key
	if ::File.size?(@response_target)
		if contents_changed?(@response_target)
			action_create
		else
			Chef::Log.info("#{@new_resource} exists at #{@new_resource.target_location} taking no action.")
		end
	else
		action_create
	end
end

action :delete do
	# Nothing
end