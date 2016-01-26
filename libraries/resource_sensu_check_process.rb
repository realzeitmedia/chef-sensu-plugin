require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckProcess < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-process.sh"
        @remote_files << {name: @cmd_name, source: "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-process.sh"}
      end

      set_attrib :process, :cmd_flag => '-p', :kind_of => String
      set_attrib :pidfile, :cmd_flag => '-f', :kind_of => String

    end
  end
end


