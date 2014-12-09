require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckRedisMemory < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        @check_type = "redis-memory"
        super
        @remote_files << {name: "check-redis-memory.rb", source: "https://github.com/sensu/sensu-community-plugins/raw/master/plugins/redis/check-redis-memory.rb"}
        @cmd_name = "check-redis-memory.rb"
      end

      set_attrib :host,      :cmd_flag => '-h', :kind_of => String
      set_attrib :port,      :cmd_flag => '-p', :kind_of => String
      set_attrib :password,  :cmd_flag => '-P', :kind_of => String
      set_attrib :warn_mem,  :cmd_flag => '-w', :kind_of => String, :required => true
      set_attrib :crit_mem,  :cmd_flag => '-c', :kind_of => String, :required => true
      set_attrib :crit_conn, :cmd_flag => '--crit-conn-failure'

    end
  end
end


