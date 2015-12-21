class EtElk
  class Helpers
    def self.generate_module_config(config, indent = 0)
      config.each_with_object([]) do |(k, v), m|
        line = (' ' * indent) + "#{k} => "
        line +=
          case v
          when String
            "\"#{v}\""
          when Fixnum, Float, TrueClass, FalseClass
            v.to_s
          when Hash
            "{\n#{generate_module_config(v, (indent + 2))}\n" +
            (' ' * indent) + '}'
          else
            fail "Unknown data type: #{v.class} for key #{k}"
          end
        m << line
      end.join("\n")
    end
  end
end
