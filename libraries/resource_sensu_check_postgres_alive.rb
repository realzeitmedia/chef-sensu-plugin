require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckPostgresAlive < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-postgres-alive.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :user,      :cmd_flag => '-u', :kind_of => String
      set_attrib :password,  :cmd_flag => '-p', :kind_of => String
      set_attrib :hostname,  :cmd_flag => '-h', :kind_of => String
      set_attrib :port,      :cmd_flag => '-P', :kind_of => String
      set_attrib :database,  :cmd_flag => '-d', :kind_of => String

    end
  end
end


