#
# Cookbook Name:: newvolume
# Resource:: cfs
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#
actions :create, :delete

attribute :cwd, :kind_of => String
attribute :diskname, :kind_of => String
attribute :argv, :kind_of => String, :default => nil
attribute :user, :kind_of => String

def initialize(*args)
  super
  @action = :create
end