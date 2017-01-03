require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckRam < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_ram

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-ram.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :megabytes, :cmd_flag => '-m'
      set_attrib :free,      :cmd_flag => '-f'
      set_attrib :used,      :cmd_flag => '-u'
      set_attrib :warn,      :cmd_flag => '-w', :kind_of => Integer
      set_attrib :crit,      :cmd_flag => '-c', :kind_of => Integer

    end
  end
end


