require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckProcess < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_process

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-process.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :warn_over,    :cmd_flag => '-w', :kind_of => Integer
      set_attrib :crit_over,    :cmd_flag => '-c', :kind_of => Integer
      set_attrib :warn_under,   :cmd_flag => '-W', :kind_of => Integer
      set_attrib :crit_under,   :cmd_flag => '-C', :kind_of => Integer
      set_attrib :metric,       :cmd_flag => '-t', :kind_of => String
      set_attrib :match_self,   :cmd_flag => '-m'
      set_attrib :match_parent, :cmd_flag => '-M'
      set_attrib :cmd_pat,      :cmd_flag => '-p', :kind_of => String
      set_attrib :exclude_pat,  :cmd_flag => '-x', :kind_of => String
      set_attrib :pidfile,      :cmd_flag => '-f', :kind_of => String # backward compatibility
      set_attrib :file_pid,     :cmd_flag => '-f', :kind_of => String
      set_attrib :vsz,          :cmd_flag => '-z', :kind_of => Integer
      set_attrib :rss,          :cmd_flag => '-r', :kind_of => Integer
      set_attrib :pcpu,         :cmd_flag => '-P', :kind_of => Float
      set_attrib :thcount,      :cmd_flag => '-T', :kind_of => Integer
      set_attrib :state,        :cmd_flag => '-s', :kind_of => String
      set_attrib :user,         :cmd_flag => '-u', :kind_of => String
      set_attrib :esec_over,    :cmd_flag => '-e', :kind_of => Integer
      set_attrib :esec_under,   :cmd_flag => '-p', :kind_of => Integer
      set_attrib :cpu_over,     :cmd_flag => '-i', :kind_of => Integer
      set_attrib :cpu_under,    :cmd_flag => '-I', :kind_of => Integer
      set_attrib :encoding,     :cmd_flag => '--encoding', :kind_of => String

    end
  end
end


