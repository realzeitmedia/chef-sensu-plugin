require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckGraphiteStats < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        @check_type = "stats"
        super
        @remote_files << {name: "check-graphite-stats.rb", source: "https://github.com/sensu/sensu-community-plugins/raw/master/plugins/graphite/check-stats.rb"}
        @cmd_name = "check-graphite-stats.rb"
      end

      set_attrib :host,   :cmd_flag => '-h', :kind_of =>String
      set_attrib :period, :cmd_flag => '-p', :kind_of => Integer, :required => true
      set_attrib :target, :cmd_flag => '-t', :kind_of => Integer, :required => true
      set_attrib :warn,   :cmd_flag => '-w', :kind_of => String
      set_attrib :crit,   :cmd_flag => '-c', :kind_of => String

    end
  end
end


