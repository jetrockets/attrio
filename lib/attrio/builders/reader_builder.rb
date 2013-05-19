# encoding: utf-8

require 'attrio/attributes/accessor_builder'

module Attrio
  module Builders
    class ReaderBuilder < AccessorBuilder

      def accessor
        :reader
      end

      def method_name
        self.method_name_from_options || self.attribute_name
      end

      def define_method
        unless self.object.method_defined?(self.method_name)
          self.object.class_eval(<<-EOS, __FILE__, __LINE__ + 1)              
            def #{method_name}              
              instance_variable_get(:#{instance_variable_name.to_s})
            end
          EOS

          self.object.send self.method_visibility, self.method_name
          self
        end
      end
    end
  end
end