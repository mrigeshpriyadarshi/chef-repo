#
# Cookbook Name:: alert_email
# Recipe:: default
#
# Copyright 2014, Mrigesh Priyadarshi
#
# All rights reserved - Do Not Redistribute
#

case node['os']
        when "linux"
                case node['platform']
                        when "redhat", "centos"
                        include_recipe "alert_email::linux"
                        else
                        	Chef::Log.info("Sorry, There is no recipe for #{node['platform']} yet!!!")
                end
        else
                Chef::Log.info("Sorry, There is no recipe for #{node['os']} yet!!!")
end