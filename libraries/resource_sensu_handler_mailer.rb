require "chef/resource"

class Chef
  class Resource
    class SensuPluginHandlerMailer < Chef::Resource::SensuPluginHandlerGeneric

      def initialize(name, run_context=nil)
        @handler_name = "mailer"
        @handler_type = "pipe"
        super
        @remote_files << {name: "mailer.rb", source: "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/mailer.rb"}
        @cmd_name = "mailer.rb"
      end

      set_attrib :admin_gui,                 :kind_of => String
      set_attrib :mail_from,                 :kind_of => String
      set_attrib :mail_to,                   :kind_of => String
      set_attrib :subscriptions,             :kind_of => Hash
      set_attrib :delivery_method,           :kind_of => String
      set_attrib :smtp_address,              :kind_of => String
      set_attrib :smtp_port,                 :kind_of => Integer
      set_attrib :smtp_domain,               :kind_of => String
      set_attrib :smtp_username,             :kind_of => String
      set_attrib :smtp_password,             :kind_of => String
      set_attrib :smtp_authentication,       :kind_of => String
      set_attrib :smtp_enable_starttls_auto, :kind_of => [TrueClass, FalseClass]
    end
  end
end


