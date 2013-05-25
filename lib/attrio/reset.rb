# encoding: utf-8

module Attrio
  module Reset
    def self.included(base)
      base.send(:extend, Attrio::Reset::ClassMethods)
    end

    module ClassMethods
      def define_attrio_reset(as)
        define_method "reset_#{as.to_s}" do |attributes_to_reset = []|
          attributes_to_reset = Array.wrap(attributes_to_reset).flatten          
          attributes_to_reset = attributes_to_reset.empty? ? self.send(as.to_s).keys : self.send(as.to_s).keys & attributes_to_reset.map!(&:to_sym)

          attributes_to_reset.each do |attribute_name|
            attribute = self.send(as.to_s)[attribute_name]
            self.send(attribute.writer_method_name, attribute.default_value)            
          end
        end

        self.send(:alias_method, "reset_#{as.to_s}!", "reset_#{as.to_s}")        
      end
    end
  end
end