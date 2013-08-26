# encoding: utf-8

require 'attrio/builders/accessor_builder'

module Attrio
  module Builders
    class ReaderBuilder < AccessorBuilder
      def self.accessor
        :reader
      end

      def self.define_accessor(klass, type, options)
        unless klass.method_defined?(options[:method_name])
          klass.send :define_method, options[:method_name] do
            self.instance_variable_get(options[:instance_variable_name])
          end

          klass.send options[:method_visibility], options[:method_name]
        end
      end
    end
  end
end