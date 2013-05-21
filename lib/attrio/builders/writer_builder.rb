# encoding: utf-8

require 'attrio/builders/accessor_builder'

module Attrio
  module Builders
    class WriterBuilder < AccessorBuilder
      def self.accessor
        :writer
      end

      def self.define_accessor(object, type, options)
        unless object.method_defined?(options[:method_name])
          object.define_method options[:method_name] do |value|            
            value = type.respond_to?(:typecast) ? type._typecast(*[value, options]) : type.new(value)
            self.instance_variable_set(options[:instance_variable_name], value)
          end
        
          object.send options[:method_visibility], options[:method_name]
        end        
      end      
    end
  end
end
