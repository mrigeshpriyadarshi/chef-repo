#
# Cookbook Name:: repomanager
# Recipe:: suse
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

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