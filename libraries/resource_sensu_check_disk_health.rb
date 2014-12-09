require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckDiskHealth < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        @check_type = "disk-health"
        super
        @remote_files << {name: "check-disk-health.rb", source: "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-disk-health.rb"}
        @cmd_name = "check-disk-health.rb"
      end

    end
  end
end


