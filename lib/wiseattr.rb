# encoding: utf-8
require 'wiseattr/version'

module Wiseattr
  autoload :AttributesBuilder, 'wiseattr/attributes_builder'
  autoload :Attributes, 'wiseattr/attributes' 

  class << self
    def define_attributes(options = {}, &block)
      options[:as] ||= :attributes
      
      cattr_accessor options[:as].to_sym
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        @@#{options[:as].to_s} ||= {}
      EOS

      unless options[:inspect] == false
        define_method(:inspect) do
          inspection = self.send(options[:as].to_s).map { |key, value|
            self.inspect_attribute(key, value[:instance_variable_name])
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

      Wiseattr::AttributesBuilder.new(self, options, &block)
    end

    def const_missing(name)
      Wiseattr::AttributesBuilder.cast_type(name) || super
    end
  end
end