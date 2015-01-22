require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckMem < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        super
        @remote_files << {name: "check-mem.rb", source: "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-mem.rb"}
        @cmd_name = "check-mem.rb"
      end

      set_attrib :warn,    :cmd_flag => '-w', :kind_of => String
      set_attrib :crit,    :cmd_flag => '-c', :kind_of => String
      set_attrib :perform, :cmd_flag => '-p'

    end
  end
end


