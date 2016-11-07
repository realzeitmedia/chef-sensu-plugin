require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckDirCount < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_dir_count

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-dir-count.rb"
        @local_files << {name: @cmd_name, source: "checks/check_dir_count.rb"}
      end

      set_attrib :directory,    :cmd_flag => '-d', :kind_of => String
      set_attrib :file_pattern, :cmd_flag => '-p', :kind_of => String
      set_attrib :warn,         :cmd_flag => '-w', :kind_of => Integer
      set_attrib :crit,         :cmd_flag => '-c', :kind_of => Integer

    end
  end
end


