require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckPostgresReplication < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_postgres_replication

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-postgres-replication.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :master_host, :cmd_flag => '-m', :kind_of => String
      set_attrib :slave_host,  :cmd_flag => '-s', :kind_of => String
      set_attrib :database,    :cmd_flag => '-d', :kind_of => String
      set_attrib :user,        :cmd_flag => '-u', :kind_of => String
      set_attrib :password,    :cmd_flag => '-p', :kind_of => String
      set_attrib :ssl,         :cmd_flag => '-S'
      set_attrib :warn,        :cmd_flag => '-w', :kind_of => Integer
      set_attrib :crit,        :cmd_flag => '-c', :kind_of => Integer
      set_attrib :timeout,     :cmd_flag => '-T', :kind_of => Integer

    end
  end
end


