#
# Cookbook Name:: newvolume
# Provider:: pvs
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

def whyrun_supported?
  true
end

action :create do
        bash "Creating physical volume #{new_resource.device} " do
                user new_resource.user
                code %{
                            pvcreate #{new_resource.device}
                }
                not_if %{ pvs  | cut -d' ' -f3  | grep "^#{new_resource.device}" || blkid | grep "^#{new_resource.device}"}
        end
end

action :delete do
  # NOTHING
end