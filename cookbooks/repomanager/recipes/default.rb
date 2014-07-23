#
# Cookbook Name:: repomanager
# Recipe:: default
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#
case node['os']
  when "linux"
	  Chef::Log.info("Its Linux")
	case node['platform']
  		when "redhat", "centos"
    			include_recipe "repomanager::redhat"
  		when "suse"
    			include_recipe "repomanager::suse"
	end
  when "windows"
    	Chef::Log.info("Its Windows...Nothing to do")
  else
    	Chef::Log.info("Oops...couldn't understand #{node.os} yet!!!")
end
