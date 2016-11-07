require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckDiskFail < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_disk_fail

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-disk-fail.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

    end
  end
end


