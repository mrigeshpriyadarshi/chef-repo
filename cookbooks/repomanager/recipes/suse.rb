#
# Cookbook Name:: repomanager
# Recipe:: suse
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

first_2_octets = node.ipaddress[/^\d+\.\d+/]

zypp = node['repomanager']['zypp']
repoList = Repomanager.getYumServer()

repomanager_repository "Mrigesh Priyadarshi" do
  	description "Mrigesh Priyadarshi corp  #{node['platform'].capitalize}-#{node['platform_version']}-#{node['kernel']['machine']}"
 	dirname zypp['dir']
  	url zypp['url']
  	reposervers repoList
  	autorefresh zypp['autorefresh']
  	enabled zypp['enable']
    	cookbook_name "repomanager"
    	cookbook_version run_context.cookbook_collection['repomanager'].metadata.version
  	action :create
end