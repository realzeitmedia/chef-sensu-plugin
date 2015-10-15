require "chef/resource"

class Chef
  class Resource
    class SensuPluginMetricCurl < Chef::Resource::SensuPluginMetricGeneric

      def initialize(name, run_context=nil)
        super
        @cmd_name = "metrics-curl.rb"
        @remote_files << {name: @cmd_name, source: "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/http/metrics-curl.rb"}
      end

      set_attrib :url,       :cmd_flag => '-u', :kind_of => String
      set_attrib :curl_args, :cmd_flag => '-a', :kind_of => String
      set_attrib :scheme,    :cmd_flag => '-s', :kind_of => String, :required => true

    end
  end
end
