require "chef/resource"

class Chef
  class Resource
    class SensuPluginHandlerSlack < Chef::Resource::SensuPluginHandlerGeneric

      def initialize(name, run_context=nil)
        @handler_name = "slack"
        @handler_type = "pipe"
        super
        @remote_files << {name: "slack.rb", source: "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/slack.rb"}
        @cmd_name = "slack.rb"
      end

      set_attrib :json_config,      :kind_of => String,  :cmd_flag => "-j", :default => 'slack'
      set_attrib :webhook_url,      :kind_of => String,  :ext_config => true
      set_attrib :channel,          :kind_of => String,  :ext_config => true
      set_attrib :message_prefix,   :kind_of => String,  :ext_config => true
      set_attrib :bot_name,         :kind_of => String,  :ext_config => true
      set_attrib :surround,         :kind_of => String,  :ext_config => true
      set_attrib :markdown_enabled, :kind_of => [TrueClass, FalseClass],  :ext_config => true

      def get_sensu_config
        config = { 'handlers' => { name => {} } }
        # The mailer plugin requires the settings in a top-level
        # element with the configuration parameters.
        config[json_config] = (get_ext_attribs).inject({}) { |hsh, key| hsh[key] = self.send(key); hsh }
        config['handlers'][name] = (get_attribs - get_cmd_attribs - get_ext_attribs).inject({}) { |hsh, key| hsh[key] = self.send(key); hsh }
        config['handlers'][name]['command'] = get_attribs.include?(:command) ? command : "#{@cmd_name}#{get_cmd_attribs.map{ |x| get_cmd_attrib x}.join""}"
        config['handlers'][name]['type']    = handler_type
        config
      end

    end
  end
end


