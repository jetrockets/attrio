# encoding: utf-8

module Attrio
  module Inspect
    def self.included(base)
      base.send(:extend, Attrio::Inspect::ClassMethods)
    end

    module ClassMethods
      def define_attrio_inspect(as)
        define_method(:inspect) do
          inspection = self.send(as.to_s).map { |key, attribute|
            self.inspect_attribute(key, attribute.instance_variable_name)
          }.compact.join(', ')

          "#<#{self.class} #{inspection}>"
        end

        define_method(:inspect_attribute) do |attribute_name, instance_variable_name|
          value = instance_variable_get(instance_variable_name.to_s)

          if value.is_a?(String) && value.length > 50
            "#{attribute_name.to_s}[#{value.size}]: " + "#{value[0..50]}...".inspect
          elsif value.is_a?(Array) && value.length > 5
            "#{attribute_name.to_s}[#{value.size}]: " + "#{value[0..5]}...".inspect
          else
            "#{attribute_name.to_s}: " + value.inspect
          end
        end
      end
    end
  end
end