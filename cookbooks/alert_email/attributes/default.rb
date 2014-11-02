#
# Cookbook Name:: alert_email
# Attribute:: default
#
# Copyright 2014, Mrigesh Priyadarshi
#
# All rights reserved - Do Not Redistribute
#

default['alert_email']['linux']['user'] = "root"
default['alert_email']['linux']['group'] = "root"
default['alert_email']['linux']['gemname'] = "chef-handler-mail"
default['alert_email']['linux']['libname'] = "mail.rb"
default['alert_email']['linux']['mail_list'] = ["mrigeshpriyadarshi@gmail.com"]