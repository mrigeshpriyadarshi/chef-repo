#
# Cookbook Name:: newvolume
# Provider:: cfs
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

def whyrun_supported?
  true
end

action :create do
        bash "Create new File System on #{new_resource.name}" do
                user new_resource.user
                cwd new_resource.cwd
                code %{
                      parted #{new_resource.argv} -- #{new_resource.diskname} mkpart primary "1" "-1"
                }
                not_if %{ fdisk -l | grep "#{new_resource.diskname}1" }
        end
end

action :delete do
  # NOTHING
end