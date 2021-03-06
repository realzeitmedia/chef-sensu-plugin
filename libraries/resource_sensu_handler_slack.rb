require "chef/resource"

class Chef
  class Resource
    class SensuPluginHandlerSlack < Chef::Resource::SensuPluginHandlerGeneric
      provides :sensu_plugin_handler_slack

      def initialize(name, run_context=nil)
        @handler_name = "slack"
        @handler_type = "pipe"
        super
        @cmd_name = "handler-slack.rb"
        @local_files << {name: @cmd_name, source: "handlers/#{@cmd_name}"}
      end

      set_attrib :json_config,      :kind_of => String,  :cmd_flag => "-j", :default => 'slack'
      set_attrib :payload_template, :kind_of => String,  :ext_config => true
      set_attrib :webhook_url,      :kind_of => String,  :ext_config => true
      set_attrib :icon_emoji,       :kind_of => String,  :ext_config => true
      set_attrib :icon_url,         :kind_of => String,  :ext_config => true
      set_attrib :channel,          :kind_of => String,  :ext_config => true
      set_attrib :message_prefix,   :kind_of => String,  :ext_config => true
      set_attrib :bot_name,         :kind_of => String,  :ext_config => true
      set_attrib :surround,         :kind_of => String,  :ext_config => true
      set_attrib :markdown_enabled, :kind_of => [TrueClass, FalseClass],  :ext_config => true
      set_attrib :link_names,       :kind_of => [TrueClass, FalseClass],  :ext_config => true
      set_attrib :template,         :kind_of => String,  :ext_config => true
      set_attrib :fields,           :kind_of => String,  :ext_config => true
      set_attrib :proxy_address,    :kind_of => String,  :ext_config => true
      set_attrib :proxy_port,       :kind_of => String,  :ext_config => true
      set_attrib :proxy_username,   :kind_of => String,  :ext_config => true
      set_attrib :proxy_password,   :kind_of => String,  :ext_config => true

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


