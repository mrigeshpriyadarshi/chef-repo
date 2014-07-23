#
# Cookbook Name:: newvolume
# Provider:: partition
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#
include Chef::Mixin::ShellOut

action :online do
                number = @new_resource.disk_number
                unless exists(number)
                        unless diskstatus(number)
                            online_disk(number)
                        end
                        remove_readonly(number)
                        clean_disk(number)
                        sleep(@new_resource.sleep)
                end
end

action :create do
                number = @new_resource.disk_number
                partition = @new_resource.partition
                unless exists(number)
                        create_partition(number, partition)
                        sleep(@new_resource.sleep)
                end
end

action :format do
                number = @new_resource.disk_number
                volume = Diskpart.getNewDiskVolume(number)
                fs = @new_resource.fs
                unless formatted(number)
                        format(number, volume, fs)
                        sleep(@new_resource.sleep)
                end
end

action :assign do
                number = @new_resource.disk_number
                letter = Diskpart.getDiskLetter()
                volume = Diskpart.getNewDiskVolume(number)
                assign(number, volume, letter)
                sleep(@new_resource.sleep)
end

def exists(disk)
        volume_info = getVolumeInfo(disk)
        puts volume_info[:volume]
        !(volume_info[:volume].nil?)
end

def diskstatus(disk)
        disk_info = getDiskInfo(disk)
        puts disk_info[:stat]
        !(disk_info[:stat] == "Offline")
end

def formatted(disk)
        volume_info = getVolumeInfo(disk)
        puts volume_info[:fs]
        !(volume_info[:fs] == "RAW")
end

def has_free_space?(disk)
        volume_info = getVolumeInfo(disk)
        free_space, units = volume_info[:disk][:free].split(' ')
        free_space.to_i > 0 && !(units == "KB" || units == "B")
end

def online_disk(disk)
        Chef::Log.debug("Changing status to online of Disk #{disk}")
        Diskpart.setup_script("select disk #{disk}\nonline disk")
        cmd = shell_out(Diskpart.diskpart, { :returns => [0] })
        Diskpart.check_for_errors(cmd, "DiskPart successfully onlined the selected disk", true)
end

def remove_readonly(disk)
        Chef::Log.debug("Removing  readonly mode of Disk #{disk}")
        Diskpart.setup_script("select disk #{disk}\nattributes disk clear readonly")
        cmd = shell_out(Diskpart.diskpart, { :returns => [0] })
        Diskpart.check_for_errors(cmd, "Disk attributes cleared successfully", true)
end

def clean_disk(disk)
        Chef::Log.debug("Cleaning Disk #{disk}")
        Diskpart.setup_script("select disk #{disk}\nclean")
        cmd = shell_out(Diskpart.diskpart, { :returns => [0] })
        Diskpart.check_for_errors(cmd, "DiskPart succeeded in cleaning the disk", true)
end

def create_partition(disk, partition)
        Chef::Log.debug("Creating partition on Disk #{disk}")
        Diskpart.setup_script("select disk #{disk}\ncreate partition #{partition}")
        cmd = shell_out(Diskpart.diskpart, { :returns => [0] })
        Diskpart.check_for_errors(cmd, "DiskPart succeeded in creating the specified partition", true)
end

def format(disk, volume, fs)
        Chef::Log.debug("Formatting disk #{disk}, Volume #{volume} with file system #{fs.to_s}")
        Diskpart.setup_script("select disk #{disk}\nselect #{volume}\nformat fs=#{fs.to_s} quick")
        cmd = shell_out(Diskpart.diskpart, { :returns => [0] })
        Diskpart.check_for_errors(cmd, "DiskPart successfully formatted the volume", true)
end

def assign(disk, volume, letter)
        Chef::Log.debug("Assigning letter #{letter} to disk #{disk}, volume #{volume}")
        Diskpart.setup_script("select disk #{disk}\nselect #{volume}\nassign letter=#{letter}")
        cmd = shell_out(Diskpart.diskpart, { :returns => [0] })
        Diskpart.check_for_errors(cmd, "DiskPart successfully assigned the drive letter or mount point", true)
end

def getVolumeInfo(disk)
        Diskpart.setup_script("select disk #{disk}\ndetail disk")
        cmd = shell_out(Diskpart.diskpart, { :returns => [0] })
        Diskpart.check_for_errors(cmd, "Disk ID:", true)
        /(?<volume>Volume\s(?<volume_number>\d{1,3}))\s{2,4}(?<letter>\s{3}|\s\w\s)\s{2}(?<label>.{0,11})\s{2}(?<fs>RAW|FAT|FAT32|exFAT|NTFS)\s{2,4}/i =~ cmd.stdout

        info = {}
        info =
                {
                      :volume => volume.nil? ? nil : volume.rstrip.lstrip,
                      :volume_number => volume_number.nil? ? nil : volume_number.rstrip.lstrip,
                      :letter => letter.nil? ? nil : letter.rstrip.lstrip,
                      :label => label.nil? ? nil : label.rstrip.lstrip,
                      :fs => fs.nil? ? nil : fs.rstrip.lstrip,
                }

        info
end


def getDiskInfo(disk)
        Diskpart.setup_script("select disk #{disk}\ndetail disk")
        cmd = shell_out(Diskpart.diskpart, { :returns => [0] })
        Diskpart.check_for_errors(cmd, "Disk ID:", true)
        /(?<status>Status :\s(?<stat>Online|Offline))/i =~ cmd.stdout

        info = {}
        info =
                {
                      :status => status.nil? ? nil : status.rstrip.lstrip,
                      :stat => stat.nil? ? nil : stat.rstrip.lstrip,
                }

        info
end