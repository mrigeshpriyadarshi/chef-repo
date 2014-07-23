#
# Cookbook Name:: repomanager
# Provider:: repository
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#

def whyrun_supported?
  true
end

action :add do
  unless ::File.exists?("#{new_resource.dirname}/#{new_resource.repo_name}.repo")
    Chef::Log.info "Adding #{new_resource.repo_name} repository to #{new_resource.dirname}/#{new_resource.repo_name}.repo"
    repo_config
  end
end

action :create do
  Chef::Log.info "Adding and updating #{new_resource.repo_name} repository in #{new_resource.dirname}/#{new_resource.repo_name}.repo"
  repo_config
end

action :remove do
  if ::File.exists?("#{new_resource.dirname}/#{new_resource.repo_name}.repo")
    Chef::Log.info "Removing #{new_resource.repo_name} repository from #{new_resource.dirname}/"
    file "#{new_resource.dirname}/#{new_resource.repo_name}.repo" do
      action :delete
    end
    new_resource.updated_by_last_action(true)
  end
end

action :update do
  repos ||= {}
  # If the repo is already enabled/disabled as per the resource, we don't want to converge the template resource.
  if ::File.exists?("#{new_resource.dirname}/#{new_resource.repo_name}.repo")
    ::File.open("#{new_resource.dirname}/#{new_resource.repo_name}.repo") do |file|
      repo_name ||= nil
      file.each_line do |line|
        case line
        when /^\[(\S+)\]/
          repo_name = $1
          repos[repo_name] ||= {}
        when /^(\S+?)=(.*)$/
          param, value = $1, $2
          repos[repo_name][param] = value
        else
        end
      end
    end
  else
    Chef::Log.error "Repo #{new_resource.dirname}/#{new_resource.repo_name}.repo does not exist, you must create it first"
  end
  if repos[new_resource.repo_name]['enabled'].to_i != new_resource.enabled
    Chef::Log.info "Updating #{new_resource.repo_name} repository in #{new_resource.dirname}/#{new_resource.repo_name}.repo (setting enabled=#{new_resource.enabled})"
    repo_config
  else
    Chef::Log.debug "Repository #{new_resource.dirname}/#{new_resource.repo_name}.repo is already set to enabled=#{new_resource.enabled}, skipping"
  end
end

private

def repo_config
  #import the gpg key. If it needs to be downloaded or imported from a cookbook
  #that can be done in the calling recipe
  if new_resource.key then
    repomanager_key new_resource.key
  end

  #write out the file
  template "#{new_resource.dirname}/#{new_resource.repo_name}.repo" do
    source "repo.erb"
    mode "0644"
    variables({
                :repo_name => new_resource.repo_name,
                :description => new_resource.description,
                :dirname => new_resource.dirname,
                :url => new_resource.url,
                :key => new_resource.key,
                :enabled => new_resource.enabled,
                :autorefresh => new_resource.autorefresh,
                :ctime => Time.now.inspect ,
                :cbname => new_resource.cookbook_name,
                :cbversion => new_resource.cookbook_version,
                :reposervers => new_resource.reposervers
              })
  end
end
