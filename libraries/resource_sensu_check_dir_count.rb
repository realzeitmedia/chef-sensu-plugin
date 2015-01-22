require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckDirCount < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        @check_type = "dir-count"
        super
        @remote_files << {name: "check-dir-count.rb", source: "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/files/check_dir_count.rb"}
        @cmd_name = "check-dir-count.rb"
      end

      set_attrib :directory, :cmd_flag => '-d', :kind_of => String
      set_attrib :warn,      :cmd_flag => '-w', :kind_of => Integer
      set_attrib :crit,      :cmd_flag => '-c', :kind_of => Integer

    end
  end
end


