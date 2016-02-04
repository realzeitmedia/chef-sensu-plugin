require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckDiskHealth < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-disk-health.sh"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

    end
  end
end


