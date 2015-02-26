#
# Cookbook Name:: intl_sys_java
# Library:: emailcbutils
#
# Copyright 2014, Mrigesh Priyadarshi
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
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