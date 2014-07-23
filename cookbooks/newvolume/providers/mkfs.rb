#
# Cookbook Name:: newvolume
# Provider:: mkfs
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

def whyrun_supported?
  true
end

action :create do
	bash "Creating  File System   #{new_resource.lvname} " do
	user new_resource.user
	code %{
		/sbin/mkfs.#{new_resource.fstype} -m0 /dev/#{new_resource.vgname}#{new_resource.index}/#{new_resource.lvname}#{new_resource.index} 
	}
	not_if %{blkid /dev/#{new_resource.vgname}#{new_resource.index}/#{new_resource.lvname}#{new_resource.index} }
	end
end

action :delete do
  # NOTHING
end