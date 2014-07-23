#
# Cookbook Name:: repomanager
# Resource:: repository
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#

actions :add, :remove, :update, :create

#name of the repo, used for .repo filename
attribute :repo_name, :kind_of => String, :name_attribute => true
attribute :description, :kind_of => String
attribute :dirname, :kind_of => String
attribute :url, :kind_of => String, :default => ""
attribute :key, :kind_of => String, :default => nil
attribute :enabled, :default => 1
attribute :autorefresh, :kind_of => String
attribute :cookbook_name, :kind_of => String
attribute :cookbook_version, :kind_of => String
attribute :reposervers, :kind_of => Array

def initialize(*args)
  super
  @action = :add
end
