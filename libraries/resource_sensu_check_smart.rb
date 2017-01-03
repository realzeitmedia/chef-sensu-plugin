require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckSmart < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_smart

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-smart.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :smart_incapable_disks, :cmd_flag => '--smart-incapable-disks', :kind_of => String

    end
  end
end


