require "chef/resource"

class Chef
  class Resource
    class SensuPluginCheckHttp < Chef::Resource::SensuPluginCheckGeneric
      provides :sensu_plugin_check_http

      def initialize(name, run_context=nil)
        super
        @cmd_name = "check-http.rb"
        @local_files << {name: @cmd_name, source: "checks/#{@cmd_name}"}
      end

      set_attrib :ua,             :cmd_flag => '-x', :kind_of => String
      set_attrib :url,            :cmd_flag => '-u', :kind_of => String
      set_attrib :host,           :cmd_flag => '-h', :kind_of =>String
      set_attrib :port,           :cmd_flag => '-P', :kind_of => Integer
      set_attrib :path,           :cmd_flag => '-p', :kind_of => String # backward compatibility
      set_attrib :request_uri,    :cmd_flag => '-p', :kind_of => String
      set_attrib :method,         :cmd_flag => '-m', :kind_of => String
      set_attrib :header,         :cmd_flag => '-H', :kind_of => String
      set_attrib :body,           :cmd_flag => '-b', :kind_of => String
      set_attrib :ssl,            :cmd_flag => '-s'
      set_attrib :insecure,       :cmd_flag => '-k'
      set_attrib :user,           :cmd_flag => '-U', :kind_of => String
      set_attrib :password,       :cmd_flag => '-a', :kind_of => String
      set_attrib :cert,           :cmd_flag => '-c', :kind_of => String
      set_attrib :cacert,         :cmd_flag => '-C', :kind_of => String
      set_attrib :expiry,         :cmd_flag => '-e', :kind_of => String
      set_attrib :pattern,        :cmd_flag => '-q', :kind_of => String
      set_attrib :negpattern,     :cmd_flag => '-n', :kind_of => String
      set_attrib :timeout,        :cmd_flag => '-t', :kind_of => Integer
      set_attrib :redirectok,     :cmd_flag => '-r'
      set_attrib :redirectto,     :cmd_flag => '-R', :kind_of => String
      set_attrib :whole_response, :cmd_flag => '-w'
      set_attrib :response_bytes, :cmd_flag => '-b', :kind_of => String
      set_attrib :require_bytes,  :cmd_flag => '-B', :kind_of => String
      set_attrib :response_code,  :cmd_flag => '--response-code', :kind_of => String
      set_attrib :proxy_url,      :cmd_flag => '--proxy-url',     :kind_of => String
      set_attrib :no_proxy,       :cmd_flag => '--no-proxy'

    end
  end
end


