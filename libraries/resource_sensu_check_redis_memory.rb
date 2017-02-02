require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckRedisMemory < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_redis_memory

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-redis-memory.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :host,      :cmd_flag => '-h', :kind_of => String
      set_attrib :port,      :cmd_flag => '-p', :kind_of => String
      set_attrib :password,  :cmd_flag => '-P', :kind_of => String
      set_attrib :warn_mem,  :cmd_flag => '-w', :kind_of => Integer, :required => true
      set_attrib :crit_mem,  :cmd_flag => '-c', :kind_of => Integer, :required => true
      set_attrib :crit_conn, :cmd_flag => '--crit-conn-failure'

    end
  end
end


