require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckGraphiteStats < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_graphite_stats

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-graphite-stats.rb"
        @local_files << {name: @cmd_name, source: "checks/check-stats.rb"}
      end

      set_attrib :host,   :cmd_flag => '-h', :kind_of => String
      set_attrib :period, :cmd_flag => '-p', :kind_of => Integer, :required => true
      set_attrib :target, :cmd_flag => '-t', :kind_of => Integer, :required => true
      set_attrib :warn,   :cmd_flag => '-w', :kind_of => String
      set_attrib :crit,   :cmd_flag => '-c', :kind_of => String

    end
  end
end


