#
# Cookbook Name:: newvolume
# Recipe:: default
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

case node['os']
        when "linux"
                case node['platform']
                        when "redhat", "centos", "suse"
                              include_recipe "newvolume::linux"
                end
        when "windows"
                include_recipe "newvolume::windows"
        else
                Chef::Log.info("Sorry, No recipe for #{node['os']} yet!!!")
end