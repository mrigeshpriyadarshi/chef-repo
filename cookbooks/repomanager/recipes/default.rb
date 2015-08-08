#
# Cookbook Name:: repomanager
# Recipe:: default
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

case node['os']
        when "linux"
                case node['platform']
                        when "redhat", "centos"
                              include_recipe "repomanager::redhat"
                        when "suse"
                              include_recipe "repomanager::suse"
                else
                        Chef::Log.info("Sorry...There is no recipe for #{node['platform']} yet!!!")
        end
else
        Chef::Log.info("Sorry...There is no recipe for #{node['os']} yet!!!")
end
