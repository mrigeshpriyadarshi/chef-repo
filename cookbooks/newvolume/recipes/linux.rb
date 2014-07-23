#
# Cookbook Name:: newvolume
# Recipe:: linux
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

oldDisk = Volume.getVolumeList()
node.set['newvolume']['diskuniq'] = Volume.getNewVolumeList(node['newvolume']['fs_scan'])
newvol = node['newvolume']

filesystem = Volume.getFileSystem( newvol['fsFile'] )
# puts newvol['diskuniq']

newvol['diskuniq'].each do | disk |
                hash = Hash[newvol['diskuniq'].map.with_index.to_a]

                execute "New Disk Lable" do
                        command "parted #{disk} mklabel msdos"
                        not_if  %{ parted #{disk} print | grep Partition }
                end

                case node['platform']
                        when "suse"
                                option = ""
                        when "redhat"
                                option = node['platform_version'].to_i < 6 ? "" : "-a optimal"
                end

                newvolume_cfs disk do
                        user "root"
                        cwd newvol['fs_scan']
                        diskname disk
                        argv option
                        action :create
                end

                newvolume_pvs "#{disk}1" do
                        user "root"
                        device "#{disk}1"
                        action :create
                end

                newvolume_vgs "#{newvol['volgrp_name']}#{hash[disk]}" do
                        user "root"
                        device "#{disk}1"
                        vgname newvol['volgrp_name']
                        index hash[disk]
                        action :create
                        not_if %{ fdisk -l | grep "#{disk}2"}
                end

                newvolume_lvs "#{newvol['logvol_name']}#{hash[disk]}" do
                        user "root"
                        lvname newvol['logvol_name']
                        vgname newvol['volgrp_name']
                        index hash[disk]
                        space newvol['lv_space'].to_i
                        action :create
                        not_if %{ fdisk -l | grep "#{disk}2"}
                end

                mkfsType = node['platform'] =~ /suse/ ? "#{filesystem}dev" : filesystem

                newvolume_mkfs "#{newvol['logvol_name']}#{hash[disk]}" do
                        user "root"
                        lvname newvol['logvol_name']
                        vgname newvol['volgrp_name']
                        index hash[disk]
                        fstype mkfsType
                        action :create
                        not_if %{ fdisk -l | grep "#{disk}2"}
                end
end

include_recipe "newvolume::mount"