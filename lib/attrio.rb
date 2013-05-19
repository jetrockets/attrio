# encoding: utf-8

require 'wiseattr/version'

module Attrio
  class << self
    def define_attributes(options = {}, &block)
      options[:as] ||= :attributes
      
      cattr_accessor options[:as].to_sym
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        @@#{options[:as].to_s} ||= {}
      EOS

      unless options[:inspect] == false
        define_method(:inspect) do
          inspection = self.send(options[:as].to_s).map { |key, value|
            self.inspect_attribute(key, value[:instance_variable_name])
          }.compact.join(', ')

          "#<#{self.class} #{inspection}>"
        end

        define_method(:inspect_attribute) do |attribute_name, instance_variable_name|
          value = instance_variable_get(instance_variable_name.to_s)

          if value.is_a?(String) && value.length > 50
            "#{attribute_name.to_s}[#{value.size}]: " + "#{value[0..50]}...".inspect
          elsif value.is_a?(Array) && value.length > 5
            "#{attribute_name.to_s}[#{value.size}]: " + "#{value[0..5]}...".inspect
          else
            "#{attribute_name.to_s}: " + value.inspect
          end
        end
        
      end

      Attrio::Attributes.new(self, options, &block)
    end

    def const_missing(name)
      Attrio::Attributes.cast_type(name) || super
    end
  end

  autoload :Attributes, 'attrio/attributes'    

  module Builders    
    autoload :ReaderBuilder, 'attrio/builders/reader_builder'
    autoload :WriterBuilder, 'attrio/builders/writer_builder'
  end

  module Types
    autoload :Base, 'attrio/types/base'
    autoload :Boolean, 'attrio/types/boolean'
    autoload :Date, 'attrio/types/date'
    autoload :DateTime, 'attrio/types/date_time'
    autoload :Float, 'attrio/types/float'
    autoload :Integer, 'attrio/types/integer'
    autoload :Symbol, 'attrio/types/symbol'
    autoload :Time, 'attrio/types/time'
  end
end