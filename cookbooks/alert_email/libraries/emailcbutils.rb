#
# Cookbook Name:: intl_sys_java
# Library:: emailcbutils
#
# Copyright 2014, Mrigesh Priyadarshi
#
# All rights reserved - Do Not Redistribute
#

class EmailCBUtils
	def self.getLibrary(gemName, libName)
		begin
			cmd = Mixlib::ShellOut.new("/opt/chef/embedded/bin/gem contents  #{gemName}")
			cmd.run_command
			lib_content_list = cmd.stdout.split("\n")
			lib = lib_content_list.keep_if { | score | score =~ /#{libName}/ }.first
		rescue Exception => e
			puts e.message
		end
		return File.dirname(lib) + "/" + File.basename(lib, ".*")
	end
end