require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckCpu < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_cpu

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-cpu.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :warn,         :cmd_flag => '-w',             :kind_of => Integer
      set_attrib :crit,         :cmd_flag => '-c',             :kind_of => Integer
      set_attrib :sleep,        :cmd_flag => '--sleep',        :kind_of => Integer
      set_attrib :proc_path,    :cmd_flag => '--proc-path',    :kind_of => String
      set_attrib :idle_metrics, :cmd_flag => '--idle-metrics', :kind_of => Array
      set_attrib :user,         :cmd_flag => '--user'
      set_attrib :nice,         :cmd_flag => '--nice'
      set_attrib :system,       :cmd_flag => '--system'
      set_attrib :idle,         :cmd_flag => '--idle'
      set_attrib :iowait,       :cmd_flag => '--iowait'
      set_attrib :irq,          :cmd_flag => '--irq'
      set_attrib :softirq,      :cmd_flag => '--softirq'
      set_attrib :steal,        :cmd_flag => '--steal'
      set_attrib :guest,        :cmd_flag => '--guest'
      set_attrib :guest_nice,   :cmd_flag => '--guest-nice'

    end
  end
end


