# encoding: utf-8

require 'attrio/builders/accessor_builder'

module Attrio
  module Builders
    class WriterBuilder < AccessorBuilder
      def self.accessor
        :writer
      end

      def self.define_accessor(klass, type, options)
        unless klass.method_defined?(options[:method_name])
          klass.send :define_method, options[:method_name] do |value|
            if !value.nil?
              value = if type.respond_to?(:typecast) && type.respond_to?(:typecasted?)
                type.typecasted?(value) ? value : type.typecast(*[value, options])
              else
                type.new(value)
              end
            end
            
            self.instance_variable_set(options[:instance_variable_name], value)
          end
        
          klass.send options[:method_visibility], options[:method_name]
        end        
      end      
    end
  end
end
