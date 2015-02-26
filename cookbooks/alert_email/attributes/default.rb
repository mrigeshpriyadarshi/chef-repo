#
# Cookbook Name:: alert_email
# Attribute:: default
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

default['alert_email']['linux']['user'] = "root"
default['alert_email']['linux']['group'] = "root"
default['alert_email']['linux']['gemname'] = "chef-handler-mail"
default['alert_email']['linux']['libname'] = "mail.rb"
default['alert_email']['linux']['recipient_mail_list'] = ["mrigeshpriyadarshi@gmail.com"]