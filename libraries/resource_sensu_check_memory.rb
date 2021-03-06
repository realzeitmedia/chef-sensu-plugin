require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckMemory < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_memory

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-memory.sh"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :warn,    :cmd_flag => '-w', :kind_of => Integer
      set_attrib :crit,    :cmd_flag => '-c', :kind_of => Integer
      set_attrib :perform, :cmd_flag => '-p'

    end
  end
end


