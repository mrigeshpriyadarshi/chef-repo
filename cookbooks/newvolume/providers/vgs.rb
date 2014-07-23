#
# Cookbook Name:: newvolume
# Provider:: vgs
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

def whyrun_supported?
  true
end

action :create do
	bash "Creating  volume  group #{new_resource.device} " do
		user new_resource.user
		code %{
			vgcreate #{new_resource.vgname}#{new_resource.index} #{new_resource.device}
		}
		not_if %{ vgs  | cut -d' ' -f3  | grep "^#{new_resource.vgname}#{new_resource.index}" }
	end
end

action :delete do
  # NOTHING
end