#
# Cookbook Name:: repomanager
# Library:: Repomanager
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

require 'chef'
$yumInfo = Chef::DataBagItem.load('yum', 'yumservers')

class Repomanager
	def self.getYumServer()
		first_2_octets = node.ipaddress[/^\d+\.\d+/]
		yumList = $yumInfo[first_2_octets]
		return yumList
	end
end