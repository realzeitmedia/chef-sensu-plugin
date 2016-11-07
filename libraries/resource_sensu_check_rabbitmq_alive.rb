require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckRabbitmqAlive < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_rabbitmq_alive

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-rabbitmq-alive.rb"
        @local_files << {name: @cmd_name, source: "checks/rabbitmq-alive.rb"}
      end

      set_attrib :host,     :cmd_flag => '-w', :kind_of => String
      set_attrib :vhost,    :cmd_flag => '-v', :kind_of => String
      set_attrib :username, :cmd_flag => '-u', :kind_of => String
      set_attrib :password, :cmd_flag => '-p', :kind_of => String
      set_attrib :port,     :cmd_flag => '-P', :kind_of => String
      set_attrib :ssl,      :cmd_flag => '--ssl', :kind_of => String

    end
  end
end


