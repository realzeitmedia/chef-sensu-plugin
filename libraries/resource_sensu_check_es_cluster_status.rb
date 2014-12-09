require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckEsClusterStatus < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        @check_type = "es-cluster-status"
        super
        @remote_files << {name: "check-es-cluster-status.rb", source: "https://github.com/sensu/sensu-community-plugins/raw/master/plugins/elasticsearch/check-es-cluster-status.rb"}
        @cmd_name = "check-es-cluster-status.rb"
      end

      set_attrib :host,        :cmd_flag => '-h', :kind_of =>String
      set_attrib :port,        :cmd_flag => '-P', :kind_of => Integer
      set_attrib :master_only, :cmd_flag => '-m'
      set_attrib :timeout,     :cmd_flag => '-t', :kind_of => Integer

    end
  end
end


