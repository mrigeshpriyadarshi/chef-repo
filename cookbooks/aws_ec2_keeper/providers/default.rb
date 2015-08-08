#
# Cookbook Name:: aws_ec2_keeper
# Provider:: default
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

include AwsEC2

def whyrun_supported?
	true
end

def install_aws_sdk
	Chef::Log.info "Installing Ruby Aws SDK!!"
	chef_gem "aws-sdk" do
		compile_time false if respond_to?(:compile_time)
	end
end

def raise_exceptions()
	require	'chef'
	puts "Raising Exceptions as resource was not created successfully "
	raise Chef::Exceptions::AttributeNotFound
end


def getInstanceslist(node_envs)
	instance_list = Array.new
	node_envs.each do | node_env |
		ec2.describe_instances(filters: [{name: "tag:ChefEnvironment", values: [node_env]}]).each do | object |
			object.instances.each do | inst |
				instance_list.push(inst.instance_id)
			end
		end
	end
	return instance_list.uniq
end

def getInstanceStatus(instances)
	status = Hash.new
	ec2.describe_instance_status(instance_ids: instances, include_all_instances: true).each do | object |
		object.instance_statuses.each do | instance_status |
			status[instance_status.instance_id] = instance_status.instance_state.name
		end
	end
	return status
end

def isInstanceStopped(instances)
	until getInstanceStatus(instances).all? { |k,v| v.eql? "stopped" }do
		puts "Waiting for Instances to be stopped.."
		sleep (10)
	end
	puts "#{instances} are Stopped.."
	return  true
end

def stop_instances(instances)
	converge_by("Stopping Instances: #{instances}") do
		begin
			puts "Stop call Initiated..."
			ec2.stop_instances(instance_ids: instances, force: true)
		rescue Exception => e
			# puts e.message
		end
		Chef::Log.info("Stopping Instances: #{instances}")
	end
	return Chef::Log.info("Stopped Instances: #{instances}") if isInstanceStopped(instances)
end

def getInstanceCheck(instances)
	status = Hash.new
	ec2.describe_instance_status(instance_ids: instances, include_all_instances: true).each do | object |
		object.instance_statuses.each do | instance_stat |
			status[instance_stat.instance_id] = instance_stat.instance_status.details[0].status
			puts instance_stat.instance_status.details[0].status
		end
	end
	return status
end

def isInstanceCheckPassed(instances)
	until getInstanceCheck(instances).all? { |k,v| v.eql? "passed" } do
		puts "Waiting for Instances Checks to be passed.."
		sleep (10)
	end
	puts "#{instances} checks are passed.."
	return  true
end

def start_instances(instances)
	converge_by("Starting Instances: #{instances}") do
		begin
			puts "Start call Initiated..."
			ec2.start_instances(instance_ids: instances, force: true)
		rescue Exception => e
			# puts e.message
		end
		Chef::Log.info("Starting Instances: #{instances}")
	end
	return Chef::Log.info("Started Instances: #{instances}") if isInstanceCheckPassed(instances)
end

action :stop_instances do
	install_aws_sdk
	instance_list = getInstanceslist(new_resource.env_list)
	stop_instances(new_resource.instance_list)

	new_resource.updated_by_last_action(true)
end

action :start_instances do
	install_aws_sdk
	instance_list = getInstanceslist(new_resource.env_list)
	start_instances(new_resource.instance_list)

	new_resource.updated_by_last_action(true)
end