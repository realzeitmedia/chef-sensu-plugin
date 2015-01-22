require "chef/resource"

class Chef
  class Resource
    class SensuPluginMetricGeneric < Chef::Resource::SensuPluginCheckGeneric

      def initialize(name, run_context=nil)
        super
        @check_type ||= "metric"
      end

      attr_reader :check_type

      def get_sensu_config
        config = super
        config['checks'][name]['type'] = check_type
        config
      end

    end
  end
end
