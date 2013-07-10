# encoding: utf-8

module Attrio
  module Inspect
    def self.included(base)    
      base.send(:extend, Attrio::Inspect::ClassMethods)
    end

    module ClassMethods
      def define_attrio_inspect(as, c_as)
        define_method(:inspect) do
          inspection = self.send(as.to_s).map { |key, attribute|
            self.inspect_attribute(key, attribute.instance_variable_name)
          }.compact

          inspection += self.send(c_as.to_s).map { |key, collection|
            self.inspect_collection(key, collection.instance_variable_name)
          }.compact

          "#<#{self.class} #{inspection.join(", ")}>"
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

        define_method(:inspect_collection) do |collection_name,instance_variable_name|
          value = instance_variable_get(instance_variable_name.to_s)
          if value.is_a?(String) && value.length > 50
            "#{collection_name.to_s}[#{value.size}]: " + "#{value[0..50]}...".inspect
          elsif value.is_a?(Array) && value.length > 5
            "#{collection_name.to_s}[#{value.size}]: " + "#{value[0..5]}...".inspect
          else
            "#{collection_name.to_s}: " + value.inspect
          end
        end

      end
    end
  end
end