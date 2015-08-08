#
# Cookbook Name:: repomanager
# Library:: repomanager
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

require 'chef'
$yumInfo = Chef::DataBagItem.load('yum', 'yumservers')

class Repomanager
	def self.getYumServer()
		first_2_octets = node.ipaddress[/^\d+\.\d+/]
		yumList = $yumInfo[first_2_octets]
		return yumList
	end
end