require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckRam < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        super
        @remote_files << {name: "check-ram.rb", source: "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-ram.rb"}
        @cmd_name = "check-ram.rb"
      end

      set_attrib :megabytes, :cmd_flag => '-m'
      set_attrib :warn,      :cmd_flag => '-w', :kind_of => Integer
      set_attrib :crit,      :cmd_flag => '-c', :kind_of => Integer

    end
  end
end


