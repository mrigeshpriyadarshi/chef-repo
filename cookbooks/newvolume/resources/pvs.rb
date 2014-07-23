#
# Cookbook Name:: newvolume
# Resource:: pvs
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

actions :create, :delete

attribute :device, :kind_of => String
attribute :user, :kind_of => String

def initialize(*args)
  super
  @action = :create
end