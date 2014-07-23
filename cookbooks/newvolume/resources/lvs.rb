#
# Cookbook Name:: newvolume
# Resource:: lvs
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

actions :create, :delete

attribute :vgname, :kind_of => String
attribute :lvname, :kind_of => String
attribute :index, :kind_of => Integer
attribute :space, :kind_of => Integer
attribute :user, :kind_of => String

def initialize(*args)
  super
  @action = :create
end