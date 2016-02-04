require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckLoad < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-load.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :warn,     :cmd_flag => '-w', :kind_of => String
      set_attrib :crit,     :cmd_flag => '-c', :kind_of => String
      set_attrib :per_core, :cmd_flag => '-p'

    end
  end
end


