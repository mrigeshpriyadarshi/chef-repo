#
# Cookbook Name:: newvolume
# Resource:: partition
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

actions :online, :create, :format, :assign, :extend

attribute :disk_number, :kind_of => Integer
attribute :fs, :kind_of => Symbol, :default => :ntfs
attribute :sleep, :kind_of => Integer, :default => 10
attribute :partition, :kind_of => String, :default => "logical"

def initialize(*args)
  super
  @action = :create
end