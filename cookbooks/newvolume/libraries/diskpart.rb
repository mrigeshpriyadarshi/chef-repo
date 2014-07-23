#
# Cookbook Name:: newvolume
# Library:: diskpart
#
# Copyright 2014, mrigeshpriyadarshi@gmail.com
#
# All rights reserved - Do Not Redistribute
#

require 'chef'

class Diskpart
    include Chef::Mixin::ShellOut
    def self.getDiskList()
              setup_script("list disk")
              cmd = %x[#{diskpart}]
              diskList = []
              info_line = cmd.scan(/Disk [0-9].*/i)
              for i in 0...info_line.length
                        diskList[i] = info_line[i].split("   ")[0]
              end
              # return attached Disk List
              return diskList
    end

    def self.getDiskLetter()
              setup_script("list volume")
              cmd = %x[#{diskpart}]
              volumeList = []
              info_line = cmd.scan(/Volume [0-9].*/i)
              for i in 0...info_line.length
                        volumeList[i] = info_line[i].split("   ")[1].rstrip.lstrip
              end
              # return Incremented value of  highest letter assigned to Volume
              return volumeList.sort.last.next
    end

    def self.getNewDiskVolume(disk)
              setup_script("select disk #{disk}\ndetail disk")
              cmd = %x[#{diskpart}]
              volumeList = []
              info_line = cmd.scan(/Volume [0-9].*/i)
              for i in 0...info_line.length
                        volumeList[i] = info_line[i].split("   ")[0].rstrip.lstrip
              end
              # return Volume of new Disk
              return volumeList.sort.last
    end

    def self.getNewDisk()
              oldList = getDiskList
              setup_script("rescan")
              cmd = %x[#{diskpart}]
              scanList = getDiskList
              #newList = scanList - oldList
              # return newly attached Disk List
              return scanList
    end

    def self.diskpart
              @diskpart ||= begin
                      "#{locate_sysnative_cmd("diskpart.exe")} /s #{script_file}"
              end
    end

    def self.setup_script(cmd)
      # Diskpart scripting requires an input script file.  We need to
      # check to see if it already exists from our last command and
      # delete it if it does before writing the new commands
                # ::File.delete(script_file) if ::File.exists?(script_file)
                begin
                            script = File.open(script_file, "w")
                            script.write(cmd) 
                rescue IOError => e
                            #some error occur, dir not writable etc.
                            puts e.message
                ensure
                            script.close unless script == nil
                end
    end

    def self.locate_sysnative_cmd(cmd)
                if ::File.exists?("#{ENV['WINDIR']}\\system32\\#{cmd}")
                          "#{ENV['WINDIR']}\\system32\\#{cmd}"
                elsif ::File.exists?("#{ENV['WINDIR']}\\sysnative\\#{cmd}")
                          "#{ENV['WINDIR']}\\sysnative\\#{cmd}"
                else
                          cmd
                end
    end

    def self.check_for_errors(cmd, expected, log = false)
                Chef::Log.debug("Output from command:\nstdout: #{cmd.stdout}\nstderr: #{cmd.stderr}") if log

                unless cmd.stderr.empty?
                        Chef::Application.fatal!(cmd.stderr)
                end

                unless cmd.stdout =~ /#{expected}/i
                        Chef::Application.fatal!(cmd.stdout)
                end
    end

    def self.script_file
                @script_file ||= "C:/tmp/diskpartScript.txt"
    end

 end

# Diskpart.getNewDisk()