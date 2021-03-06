require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckEsClusterStatus < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_es_cluster_status

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-es-cluster-status.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :host,           :cmd_flag => '-h', :kind_of => String
      set_attrib :port,           :cmd_flag => '-p', :kind_of => Integer
      set_attrib :master_only,    :cmd_flag => '-m'
      set_attrib :timeout,        :cmd_flag => '-t', :kind_of => Integer
      set_attrib :timeout,        :cmd_flag => '-t', :kind_of => Integer
      set_attrib :status_timeout, :cmd_flag => '-T', :kind_of => Integer
      set_attrib :user,           :cmd_flag => '-u', :kind_of => String
      set_attrib :password,       :cmd_flag => '-P', :kind_of => String
      set_attrib :https,          :cmd_flag => '-e'

    end
  end
end


