require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckDisk < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        super
        @remote_files << {name: "check-disk.rb", source: "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-disk.rb"}
        @cmd_name = "check-disk.rb"
      end

      set_attrib :fstype,      :cmd_flag => '-t', :kind_of => String
      set_attrib :ignoretype,  :cmd_flag => '-x', :kind_of => String
      set_attrib :ignoremnt,   :cmd_flag => '-i', :kind_of => String
      set_attrib :ignoreline,  :cmd_flag => '-l', :kind_of => String
      set_attrib :includeline, :cmd_flag => '-L', :kind_of => String
      set_attrib :warn,        :cmd_flag => '-w', :kind_of => Integer
      set_attrib :crit,        :cmd_flag => '-c', :kind_of => Integer
      set_attrib :iwarn,       :cmd_flag => '-W', :kind_of => Integer
      set_attrib :icrit,       :cmd_flag => '-K', :kind_of => Integer
      set_attrib :debug,       :cmd_flag => '-d', :kind_of => String

    end
  end
end


