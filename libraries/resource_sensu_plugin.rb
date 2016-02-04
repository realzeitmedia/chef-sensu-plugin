require "chef/resource"

class Chef
  class Resource
    class SensuPluginPlugin < Chef::Resource
      # This makes sure that @required_attributes ends up as an independent class
      # instance variable in each class that inherits from SensuPluginPlugin. Otherwise
      # it would be shared among all parents and siblings.
      class << self
        attr_accessor :required_attribs
        attr_accessor :cmd_flags
        attr_accessor :ext_attribs

        def inherit_attributes(ra, ea)
          @required_attribs ||= []
          @required_attribs.concat ra
          @ext_attribs ||= []
          @ext_attribs.concat ea
        end

        def inherit_flags(flags)
          @cmd_flags ||= {}
          @cmd_flags.merge! flags
        end

        def inherited(subclass)
          subclass.inherit_attributes(@required_attribs, @ext_attribs)
          subclass.inherit_flags(@cmd_flags)
        end
      end

      @required_attribs = []
      @ext_attribs = []
      @cmd_flags = {}

      def initialize(name, run_context=nil)
        super
        @allowed_actions = [:create, :nothing]
        @cookbook = 'sensu-plugin'
        # Save all attributes that have actually been called in the recipe
        @attribs = []
      end

      def cookbook(arg=nil)
        set_or_return(:cookbook, arg, :kind_of => String)
      end

      #attr_reader :attribs

      def set_or_return(symbol, arg, validation)
        iv_symbol = "@#{symbol.to_s}".to_sym

        if arg == nil && self.instance_variable_defined?(iv_symbol) == true
          self.instance_variable_get(iv_symbol)
        else
          opts = validate({ symbol => arg }, { symbol => validation })
          self.instance_variable_set(iv_symbol, opts[symbol])
        end
      end

      def get_attribs
        if self.class.required_attribs.kind_of? Array
          (self.class.required_attribs + @attribs).flatten.uniq
        else
          @attribs.flatten.uniq
        end
      end

      def get_cmd_attribs
        cmd_attribs = []
        get_attribs.each { |attrib| cmd_attribs << attrib if self.class.cmd_flags[attrib] }
        cmd_attribs
      end

      def get_ext_attribs
        ext_attribs = []
        get_attribs.each { |attrib| ext_attribs << attrib if self.class.ext_attribs.include?(attrib) }
        ext_attribs
      end

      def get_cmd_attrib(attrib)
        return "" unless get_attribs.include? attrib

        if self.class.cmd_flags[attrib]
          val = send(attrib)
          return "" if val.kind_of?(FalseClass)
          if val.kind_of? TrueClass
            " #{self.class.cmd_flags[attrib]}"
          else
            " #{self.class.cmd_flags[attrib]} #{val}"
          end
        else
          " #{send attrib}"
        end
      end

      # Stolen from chef's LWRP implementation
      def self.set_attrib(attr_name, validation_opts={})
        # Ruby 1.8 doesn't support default arguments to blocks, but we have to
        # use define_method with a block to capture +validation_opts+.
        # Workaround this by defining two methods :(

        if validation_opts.has_key? :cmd_flag
          @cmd_flags[attr_name.to_sym] = validation_opts.delete :cmd_flag
        end

        if validation_opts.has_key? :ext_config
          @ext_attribs << attr_name.to_sym
          validation_opts.delete :ext_config
        end

        class_eval(<<-SHIM, __FILE__, __LINE__)
          def #{attr_name}(arg=nil)
            _set_or_return_#{attr_name}(arg)
          end
        SHIM
        if validation_opts[:required]
          @required_attribs << attr_name.to_sym
        end

        define_method("_set_or_return_#{attr_name.to_s}".to_sym) do |arg|
          unless arg.nil?
            @attribs << attr_name.to_sym
          end
          set_or_return(attr_name.to_sym, arg, validation_opts)
        end
      end

    end
  end
end
