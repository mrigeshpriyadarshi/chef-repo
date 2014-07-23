#
# Cookbook Name:: repomanager
# Recipe:: redhat
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

yum = node['repomanager']['yum']
repoList = Repomanager.getYumServer()

repomanager_repository "Mrigesh Priyadarshi" do
  	description "Mrigesh Priyadarshi INC  #{node['platform'].capitalize}-#{node['platform_version']}-#{node['kernel']['machine']}"
  	dirname yum['dir']
  	url yum['url']
  	key yum['key']
  	enabled yum['enable']
  	reposervers repoList
    	cookbook_name "repomanager"
    	cookbook_version run_context.cookbook_collection['repomanager'].metadata.version
  	action :create
end