#
# Cookbook Name:: alert_email
# Recipe:: linux
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

mail = node['alert_email']['linux']

# Installing Chef Mail Handler Gem
chef_gem mail['gemname'] do
	action :install
end

# '/opt/chef/embedded/lib/ruby/gems/1.9.1/gems/chef-handler-mail-0.1.2/lib/chef/handler/mail'
# Configuring the handler
chef_handler "MailHandler" do
	source lazy { EmailCBUtils.getLibrary(mail['gemname'], mail['libname']) }
	arguments :to_address => mail["recipient_mail_list"]
	supports :exception => true, :report => true
	action :nothing
end.run_action(:enable)