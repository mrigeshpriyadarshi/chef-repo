# Cookbook Name:: newvolume
# Recipe:: mount
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

newvol=node['newvolume']
filesys = Volume.getFileSystem( newvol['fsFile'] )
index = Volume.getDataIndex()

execute "Check old #{newvol['first_lvmount']} and Move" do
                user "root"
                command "mv #{newvol['first_lvmount']} #{newvol['first_lvmount']}_old"
                only_if %{ ls -d #{newvol['first_lvmount']} && ! lsblk | grep #{newvol['first_lvmount']} }
end

newvol['diskuniq'].each do | disk |
                directory "#{newvol['rest_lvmount']}#{index}" do
                            owner "root"
                            group "root"
                            mode 00755
                            recursive true
                            action :create
                            only_if  %{ grep "#{newvol['first_lvmount']}" /etc/fstab && ! grep "^#{newvol['rest_lvmount']}#{index}" /etc/fstab} 
                end

                newvolume_mount "#{newvol['rest_lvmount']}#{index}" do
                            user "root"
                            mountloc "#{newvol['rest_lvmount']}#{index}"
                            fstype filesys
                            device disk
                            action :create
                            only_if  %{ grep "#{newvol['first_lvmount']}" /etc/fstab && ! grep "^#{newvol['rest_lvmount']}#{index}" /etc/fstab} 
                end

                directory newvol['first_lvmount'] do
                            owner "root"
                            group "root"
                            mode 00755
                            recursive true
                            action :create
                            not_if  %{ grep "#{newvol['first_lvmount']}" /etc/fstab && mount -l | grep #{disk}1 } 
                end

                newvolume_mount newvol['first_lvmount'] do
                            user "root"
                            mountloc newvol['first_lvmount']
                            fstype filesys
                            device disk
                            action :create
                            not_if  %{ grep "#{newvol['first_lvmount']}" /etc/fstab && mount -l | grep #{disk}1 }
                end
                
                index += 1
end

execute "Move old #{newvol['first_lvmount']} to new" do
                user "root"
                command "mv #{newvol['first_lvmount']}_old/* #{newvol['first_lvmount']}"
                only_if %{ ls -d #{newvol['first_lvmount']}_old && lsblk | grep #{newvol['first_lvmount']} }
end