#
# Cookbook Name:: newvolume
# Provider:: lvs
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

def whyrun_supported?
  true
end

action :create do
	bash "Creating  logical volume   #{new_resource.lvname} " do
		user new_resource.user
		code %{
			lvcreate -n /dev/#{new_resource.vgname}#{new_resource.index}/#{new_resource.lvname}#{new_resource.index} -l#{new_resource.space}%vg
		}
		not_if %{ lvs  | cut -d' ' -f3  | grep "^#{new_resource.lvname}#{new_resource.index}" }
	end
end

action :delete do
  # NOTHING
end