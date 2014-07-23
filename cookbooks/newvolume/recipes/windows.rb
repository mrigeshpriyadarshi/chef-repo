#
# Cookbook Name:: newvolume
# Recipe:: windows
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

diskList = Diskpart.getNewDisk()

diskList.each do |disk|
	newvolume_partition disk do
	        disk_number disk.split(" ").last.to_i
	        action :online
	        not_if { disk == "Disk 0" }
	end

	newvolume_partition disk do
	        disk_number disk.split(" ").last.to_i
	        fs :ntfs
	        partition "extended"
	        action :create
	        not_if { disk == "Disk 0" }
	end

	newvolume_partition disk do
	        disk_number disk.split(" ").last.to_i
	        fs :ntfs
	        partition "logical"
	        action :create
	        not_if { disk == "Disk 0" }
	end

	newvolume_partition disk do
	        disk_number disk.split(" ").last.to_i
	        action :assign
	        not_if { disk == "Disk 0" }
	end

	newvolume_partition disk do
	        disk_number disk.split(" ").last.to_i
	        fs :ntfs
	        action :format
	        not_if { disk == "Disk 0" }
	end
end