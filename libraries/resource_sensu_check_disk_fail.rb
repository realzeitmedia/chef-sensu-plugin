require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckDiskFail < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        super
        @remote_files << {name: "check-disk-fail.rb", source: "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-disk-fail.rb"}
        @cmd_name = "check-disk-fail.rb"
      end

    end
  end
end


