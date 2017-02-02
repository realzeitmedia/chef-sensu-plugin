require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckDirCount < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_dir_count

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-dir-count.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :directory,    :cmd_flag => '-d', :kind_of => String,  :required => true
      set_attrib :warn,         :cmd_flag => '-w', :kind_of => Integer, :required => true
      set_attrib :crit,         :cmd_flag => '-c', :kind_of => Integer, :required => true

    end
  end
end


