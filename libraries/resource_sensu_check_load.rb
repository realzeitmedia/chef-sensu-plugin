require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckLoad < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        super
        @remote_files << {name: "check-load.rb", source: "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-load.rb"}
        @cmd_name = "check-load.rb"
      end

      set_attrib :warn,     :cmd_flag => '-w', :kind_of => String
      set_attrib :crit,     :cmd_flag => '-c', :kind_of => String
      set_attrib :per_core, :cmd_flag => '-p'

    end
  end
end


