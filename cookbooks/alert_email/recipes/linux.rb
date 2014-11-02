#
# Cookbook Name:: alert_email
# Recipe:: linux
#
# Copyright 2014, Mrigesh Priyadarshi
#
# All rights reserved - Do Not Redistribute
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
	arguments :to_address => mail["mail_list"]
	supports :exception => true, :report => true
	action :nothing
end.run_action(:enable)