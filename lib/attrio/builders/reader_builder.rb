# encoding: utf-8

require 'attrio/builders/accessor_builder'

module Attrio
  module Builders
    class ReaderBuilder < AccessorBuilder
      def self.accessor
        :reader
      end

      def self.define_accessor(object, type, options)
        unless object.method_defined?(options[:method_name])
          object.send :define_method, options[:method_name] do            
            self.instance_variable_get(options[:instance_variable_name])
          end
        
          object.send options[:method_visibility], options[:method_name]
        end        
      end      
    end
  end
end