require "chef/resource"

class Chef
  class Resource
    class SensuPluginMetricPing < Chef::Resource::SensuPluginMetricGeneric
      provides :sensu_plugin_metric_ping

      def initialize(name, run_context=nil)
        super
        @cmd_name = "metrics-ping.rb"
        @local_files << {name: @cmd_name, source: "metrics/#{@cmd_name}"}
      end

      set_attrib :scheme,    :cmd_flag => '-s', :kind_of => String, :required => true
      set_attrib :host,      :cmd_flag => '-h', :kind_of => String
      set_attrib :count,     :cmd_flag => '-c', :kind_of => Integer
      set_attrib :timeout,   :cmd_flag => '-t', :kind_of => Integer

    end
  end
end
