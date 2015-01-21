require "chef/resource"

class Chef
  class Resource
    class SensuPluginHandlerGeneric < Chef::Resource::SensuPluginPlugin

      def initialize(name, run_context=nil)
        super
        @category = "handler"
        @handler_name ||= "generic"
        @handler_type ||= "pipe"
        @resource_name = "sensu_plugin_#{@category}_#{@handler_name}".to_sym
        @provider = Chef::Provider::SensuPluginPlugin
        @local_files = []
        @remote_files = []
        @gems = []
        @action = :create
      end

      attr_reader :category
      attr_reader :handler_name
      attr_reader :handler_type
      attr_reader :remote_files
      attr_reader :local_files
      attr_reader :gems

      set_attrib :command,    kind_of: String
      set_attrib :handlers,   kind_of: Array, :default => ["default"]
      set_attrib :severities, kind_of: Array

      def get_sensu_config
        config = { 'handlers' => { name => {} } }
        config['handlers'][name] = get_attribs.inject({}) { |hsh, key| hsh[key] = self.send(key); hsh }
        config['handlers'][name]['command']     = get_attribs.include?(:command) ? command : "#{@cmd_name}#{get_cmd_attribs.map{ |x| get_cmd_attrib x}.join""}"
        config['handlers'][name]['type']    = handler_type
        config
      end

    end
  end
end

