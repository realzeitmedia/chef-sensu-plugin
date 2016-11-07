require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckMem < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_mem

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-mem.sh"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :warn,    :cmd_flag => '-w', :kind_of => String
      set_attrib :crit,    :cmd_flag => '-c', :kind_of => String
      set_attrib :perform, :cmd_flag => '-p'

    end
  end
end


