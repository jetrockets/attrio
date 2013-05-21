# encoding: utf-8

module Attrio
  module Reset
    def self.included(base)    
      base.send(:extend, Attrio::Reset::ClassMethods)
    end

    module ClassMethods
      def define_attrio_reset(as)
        define_method "reset_#{as.to_s}" do
          self.send(as.to_s).values.each do |attribute|
            self.instance_variable_set(attribute[:instance_variable_name], nil)
          end
        end      

        self.send(:alias_method, "reset_#{as.to_s}!", "reset_#{as.to_s}")  
      end
    end
  end
end