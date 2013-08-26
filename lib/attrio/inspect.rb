# encoding: utf-8

module Attrio
  module Inspect
    def inspect
      inspection = []

      self.class.attrio.each do |group, options|
        unless options[:inspect] == false
          inspection << self.send(group).map { |key, attribute|
            self.inspect_attribute(key, attribute.instance_variable_name)
          }
        end
      end

      unless inspection.size == 0
        "#<#{self.class} #{inspection.flatten.compact.join(', ')}>"
      else
        super
      end
    end

    def inspect_attribute(attribute_name, instance_variable_name)
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