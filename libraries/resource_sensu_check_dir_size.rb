require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckDirSize < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_dir_size

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-dir-size.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :directory,      :cmd_flag => '-d', :kind_of => String,  :required => true
      set_attrib :warn,           :cmd_flag => '-w', :kind_of => Integer
      set_attrib :crit,           :cmd_flag => '-c', :kind_of => Integer
      set_attrib :du_path,        :cmd_flag => '-p', :kind_of => String
      set_attrib :ignore_missing, :cmd_flag => '--ignore-missing'

    end
  end
end


