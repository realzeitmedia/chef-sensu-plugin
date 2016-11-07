require "chef/resource"

class Chef
  class Resource
    class SensuPluginHandlerMailer < Chef::Resource::SensuPluginHandlerGeneric
      provides :sensu_plugin_handler_mailer

      def initialize(name, run_context=nil)
        @handler_name = "mailer"
        @handler_type = "pipe"
        super
        @cmd_name = "mailer.rb"
        @local_files << {name: @cmd_name, source: "handlers/#{@cmd_name}"}
        @gems += [{name: "mail", version: "2.5.4"}, {name: "timeout"}]
      end

      set_attrib :json_config,               :kind_of => String,  :cmd_flag => "-j", :default => 'mailer'
      set_attrib :admin_gui,                 :kind_of => String
      set_attrib :mail_from,                 :kind_of => String,  :ext_config => true
      set_attrib :mail_to,                   :kind_of => String,  :ext_config => true
      set_attrib :subscriptions,             :kind_of => Hash
      set_attrib :delivery_method,           :kind_of => String,  :ext_config => true
      set_attrib :smtp_address,              :kind_of => String,  :ext_config => true
      set_attrib :smtp_port,                 :kind_of => Integer, :ext_config => true
      set_attrib :smtp_domain,               :kind_of => String,  :ext_config => true
      set_attrib :smtp_username,             :kind_of => String,  :ext_config => true
      set_attrib :smtp_password,             :kind_of => String,  :ext_config => true
      set_attrib :smtp_authentication,       :kind_of => String,  :ext_config => true
      set_attrib :smtp_enable_starttls_auto, :kind_of => [TrueClass, FalseClass], :ext_config => true

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


