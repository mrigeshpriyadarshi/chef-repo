#
# Cookbook Name:: newvolume
# Library:: default
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#
require 'chef'

class Volume  
	def self.getVolumeList()
              begin
                       disk_list = %x[ fdisk -l | grep Disk | grep dev | cut -d' '  -f2 | cut -d: -f1 ].split("\n")
                  rescue Exception => e
                       puts e.message
              end
              #puts status
  	       return disk_list
	end

        def self.getMapperList()
              begin
                       mapper_list = %x[ find /dev/mapper -type l ].split("\n")
                  rescue Exception => e
                       puts e.message
              end
              #puts status
              return mapper_list
        end

        def self.getNewVolume(dir)
              begin
                value = %x[ i=0
                    count=$(ls -ld #{dir}/host* | wc -l)
                    while (( $i < $count )); do
                            echo "- - -" > #{dir}/host$i/scan
                            let  i=i+1
                            echo "host"$i
                            sleep 5
                      done]
                      sleep(50)
                      rescue Exception => e
                            puts e.message
              end
              return Volume.getVolumeList()
        end

        def self.getNewVolumeList(dir)
                begin
                  new_list= Volume.getNewVolume(dir)
                  mapperList = Volume.getMapperList()
                  old_list= %x[blkid | grep swap].split(":")[0].sub(/[0-9]/,"").split("\n")
                  new_list = new_list - old_list - mapperList
                  rescue Exception => e
                    puts e.message
                end
              #puts status
           return new_list
        end

        def self.getMountInfo(loc)
              begin
                       mountinfo = %x[ grep "#{loc}" /etc/fstab ]
                  rescue Exception => e
                       puts e.message
              end
              #puts status
           return mountinfo
        end

        def self.getFileSystem(filename)
              begin
                       filesystem = %x[cat #{filename}].scan(/ext[0-9]/).sort.last.rstrip.lstrip
                  rescue Exception => e
                       puts e.message
              end
              #puts status
           return filesystem
        end

        def self.getDataIndex()
              begin
                      value = %x[ cat /etc/fstab | awk '{print $2}' | grep ^/data].split("\n").sort { |x,y| y <=> x }[0].to_s
                      count = value  =~ /nil/ ? "nil" : value.sub("/data","")
                      index = count.to_i
              rescue Exception => e
                       puts e.message
              end
              #puts status
           return index
        end
end

# Volume.getDataIndex()