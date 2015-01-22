require "chef/resource"

class Chef
  class Resource
    class SensuPluginHandlerTCP < Chef::Resource::SensuPluginHandlerGeneric

      def initialize(name, run_context=nil)
        @handler_name = "tcp"
        @handler_type = "tcp"
        super
      end

      set_attrib :host, :kind_of => String,  :required => true
      set_attrib :port, :kind_of => Integer, :required => true
    end
  end
end
