#
# Cookbook Name:: newvolume
# Resource:: mount
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#
actions :create, :delete, :nothing

attribute :mountloc, :kind_of => String
attribute :index, :kind_of => Integer
attribute :fstype, :kind_of => String
attribute :vgname, :kind_of => String
attribute :device, :kind_of => String
attribute :user, :kind_of => String

def initialize(*args)
  super
  @action = :create
end