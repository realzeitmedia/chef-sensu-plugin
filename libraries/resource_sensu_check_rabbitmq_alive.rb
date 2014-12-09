require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckRabbitmqAlive < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        @check_type = "rabbitmq-alive"
        super
        @remote_files << {name: "check-rabbitmq-alive.rb", source: "https://github.com/sensu/sensu-community-plugins/raw/master/plugins/rabbitmq/rabbitmq-alive.rb"}
        @cmd_name = "check-rabbitmq-alive.rb"
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


