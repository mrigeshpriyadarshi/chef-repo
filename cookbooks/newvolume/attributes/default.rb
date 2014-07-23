#
# Cookbook Name:: newvolume
# Attribute:: default
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute

#Linux Attributes
default['newvolume']['fs_scan']= "/sys/class/scsi_host"
default['newvolume']['volgrp_name']= "vgdata"
default['newvolume']['logvol_name']= "data"
default['newvolume']['logvol_path']= "/dev/#{node['newvolume']['volgrp_name']}/#{node['newvolume']['logvol_name']}"
default['newvolume']['lv_space']= "100"
default['newvolume']['first_lvmount']= "/export/home"
default['newvolume']['rest_lvmount']= "/data"
default['newvolume']['nativedisk']= ["/dev/sda"] 
default['newvolume']['fsFile'] = "/proc/filesystems"

#Windows Attributes