#
# Cookbook Name:: awscli
# Providers:: cloudformation
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


action :create do
	cfn_template = new_resource.cfn_template_loc + "/" + new_resource.cfn_template

	execute "Executing Cloud formation template to Create Stack" do
		cwd new_resource.cfn_template_loc
		command "aws cloudformation create-stack --stack-name #{new_resource.stack_name} --template-body file:///#{cfn_template}"
		environment  ({'PATH' => "#{new_resource.aws_home}:#{ENV['PATH']}"})
	end

	new_resource.updated_by_last_action(true)	
end

action :delete do
	cfn_template = new_resource.cfn_template_loc + "/" + new_resource.cfn_template

	execute "Executing Cloud formation template to Create Stack" do
		cwd new_resource.cfn_template_loc
		command "aws cloudformation delete-stack --stack-name #{new_resource.stack_name} --template-body file:///#{cfn_template}"
		environment  ({'PATH' => "#{new_resource.aws_home}:#{ENV['PATH']}"})
	end

	new_resource.updated_by_last_action(true)
end