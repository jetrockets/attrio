# encoding: utf-8

require 'attrio/attributes/accessor_builder'

module Attrio
  module Builders
    class WriterBuilder < AccessorBuilder
      
      def accessor
        :writer
      end

      def method_name
        self.method_name_from_options || "#{self.attribute_name}="
      end

      def define_method
        unless self.object.method_defined?(self.method_name)
          self.object.class_eval(<<-EOS, __FILE__, __LINE__ + 1)              
            def #{self.method_name}(value)
              value = #{type}.respond_to?(:typecast) ? #{type}.typecast(value) : #{type}.new(value)
              instance_variable_set(:#{instance_variable_name.to_s}, value)
            end
          EOS

          self.object.send self.method_visibility, self.method_name
          self
        end        
      end
    end
  end
end
