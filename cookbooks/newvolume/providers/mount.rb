#
# Cookbook Name:: newvolume
# Provider:: mount
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#
def whyrun_supported?
  true
end

action :create do
        bash "Creating Mount for #{new_resource.mountloc} " do
                user new_resource.user
                code %{ 
                                vol_n=$(pvs #{new_resource.device}1 --noheadings | awk '{print $2}')
                                lvm_n=$(lvs $vol_n --noheadings | awk '{print $1}')
                                if [[ $(grep "/dev/$vol_n/$lvm_n" /etc/fstab) == "" ]]
                                  then
                                      /bin/echo "/dev/$vol_n/$lvm_n   #{new_resource.mountloc}                    #{new_resource.fstype}    defaults        0 2" >> /etc/fstab
                                      bin/mount  #{new_resource.mountloc}
                                      sleep 30
                                  else
                                       echo "Already Mounted!!!"
                                   fi
                              }
                not_if %{ mount -l | grep #{new_resource.device}1 }
        end
end

action :delete do
  # NOTHING
end

action :nothing do
  # NOTHING
end