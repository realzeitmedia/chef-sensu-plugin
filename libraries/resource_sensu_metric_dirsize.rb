require "chef/resource"

class Chef
  class Resource
    class SensuPluginMetricDirsize < Chef::Resource::SensuPluginMetricGeneric
      provides :sensu_plugin_metric_dirsize

      def initialize(name, run_context=nil)
        super
        @cmd_name = "metric-dirsize.rb"
        @local_files << {name: @cmd_name, source: "metrics/#{@cmd_name}"}
      end

      set_attrib :directory, :cmd_flag => '-d', :kind_of => String, :required => true
      set_attrib :real_size, :cmd_flag => '-r'
      set_attrib :apparent_size, :cmd_flag => '-a'
      set_attrib :inodes, :cmd_flag => '-i'
      set_attrib :scheme, :cmd_flag => '--scheme', :kind_of => String, :default => "stats.:::name:::", :required => true
    end
  end
end
