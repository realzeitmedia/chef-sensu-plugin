require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckProcess < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_process

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-process.sh"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :process, :cmd_flag => '-p', :kind_of => String
      set_attrib :pidfile, :cmd_flag => '-f', :kind_of => String

    end
  end
end


