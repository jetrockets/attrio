# encoding: utf-8

module Attrio
  module Initialize
    def self.included(base)
      base.send(:extend, Attrio::Initialize::ClassMethods)
    end

    module ClassMethods
      def define_attrio_new(as)
        define_method("initialize_#{as}_default_values") do
          self.send(as).values.each do |attribute|
            unless self.instance_variable_get(attribute[:instance_variable_name]).present?
              self.instance_variable_set(attribute[:instance_variable_name], attribute[:default_value]) 
            end
          end
        end

        define_singleton_method(:new) do |*args, &block|
          obj = self.allocate
          obj.send :initialize, *args, &block
          obj.send "initialize_#{as}_default_values"
          obj
        end
      end
    end
  end
end