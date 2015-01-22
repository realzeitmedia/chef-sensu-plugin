require "chef/resource"

class Chef
  class Resource
    class SensuPluginMetricVmstat < Chef::Resource::SensuPluginMetricGeneric

      def initialize(name, run_context=nil)
        super
        @cmd_name = "vmstat-metrics.rb"
        @remote_files << {name: @cmd_name, source: "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/vmstat-metrics.rb"}
      end

      set_attrib :scheme, :cmd_flag => '--scheme', :kind_of => String, :default => "stats.:::name:::", :required => true

    end
  end
end
