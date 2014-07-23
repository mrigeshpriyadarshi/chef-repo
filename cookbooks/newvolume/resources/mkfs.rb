#
# Cookbook Name:: newvolume
# Resource:: mkfs
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

actions :create, :delete

attribute :vgname, :kind_of => String
attribute :lvname, :kind_of => String
attribute :index, :kind_of => Integer
attribute :fstype, :kind_of => String
attribute :user, :kind_of => String

def initialize(*args)
  super
  @action = :create
end