require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckGeneric < Chef::Resource::SensuPluginPlugin

      def initialize(name, run_context=nil)
        super
        @category = "check"
        @check_name ||= "generic"
        @resource_name = "sensu_plugin_#{@category}_#{@check_name}".to_sym
        @provider = Chef::Provider::SensuPluginPlugin
        @local_files = []
        @remote_files = []
        @gems = []
        @action = :create
        @allowed_actions = [:create, :enable]
      end

      attr_reader :category
      attr_reader :remote_files
      attr_reader :local_files
      attr_reader :gems

      set_attrib :command,     :kind_of => String
      set_attrib :handlers,    :kind_of => Array,   :default => ["default"], :required => true
      set_attrib :severities,  :kind_of => Array
      set_attrib :occurrences, :kind_of => Integer, :default => 2, :required => true
      set_attrib :refresh,     :kind_of => Integer
      set_attrib :subscribers, :kind_of => Array
      set_attrib :interval,    :kind_of => Integer, :default => 300, :required => true
      set_attrib :timeout,     :kind_of => Integer
      set_attrib :standalone,  :kind_of => [TrueClass, FalseClass]

      def get_sensu_config
        config = { 'checks' => { name => {} } }

        config['checks'][name] = (get_attribs - get_cmd_attribs - get_ext_attribs).inject({}) { |hsh, key| hsh[key] = self.send(key); hsh }
        config['checks'][name]['command'] = get_attribs.include?(:command) ? command : "#{@cmd_name}#{get_cmd_attribs.map{ |x| get_cmd_attrib x}.join""}"
        config
      end

    end
  end
end

