# encoding: utf-8

module Attrio
  module Reset
    def self.included(base)
      base.send(:extend, Attrio::Reset::ClassMethods)
    end

    module ClassMethods
      def define_attrio_reset(as)
        define_method "reset_#{as.to_s}" do |attributes = []|          
          self.send(as.to_s, attributes).values.each{ |attribute| self.send(attribute.writer_method_name, nil) }
          self.send("set_#{as.to_s}_defaults", attributes)
        end  

        define_method "reset_#{as.to_s}_defaults" do |attributes = []|
          self.send(as.to_s, attributes).values.select(&:default_value).each { |attribute| self.send(attribute.writer_method_name, nil) }
          self.send("set_#{as.to_s}_defaults", attributes)          
        end

        define_method "set_#{as.to_s}_defaults" do |attributes = []|
          self.send(as.to_s, attributes).values.select(&:default_value).each do |attribute|
            next if self.send(attribute.reader_method_name).present?

            default_value = attribute.default_value.is_a?(Attrio::DefaultValue::Base) ? attribute.default_value.call(self) : attribute.default_value  
            self.send(attribute.writer_method_name, default_value)
          end          
        end
      end
    end
  end
end