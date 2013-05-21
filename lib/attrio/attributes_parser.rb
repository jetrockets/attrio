# encoding: utf-8

module Attrio
  class AttributesParser
    attr_reader :klass, :options

    def initialize(object, options, &block)
      @object = object
      @options = options

      raise ArgumentError.new('Missing options[:as] value' ) if @options[:as].blank?

      self.instance_eval(&block)
    end

    def attr(*args)
      attribute_options = args.extract_options!
      attribute_name = args[0].to_s

      type = self.class.cast_type(attribute_options.delete(:type) || args[1])      
      self.class.const_missing(type.to_s) if type.blank?

      attribute = Attrio::Attribute.new(@object, attribute_name, type, attribute_options).define_writer.define_reader
      self.add_attribute(attribute_name, attribute)
      # self.add_attribute(type, attribute_name, attribute_options)

      # reader_builder = Attrio::Builders::ReaderBuilder.new(@object, as, attribute_name)
      # writer_builder = Attrio::Builders::WriterBuilder.new(@object, as, attribute_name)
      
      # reader_builder.define_method.define_aliases
      # writer_builder.define_method.define_aliases
    end

    def self.cast_type(constant)
      return constant if constant.is_a?(Class) && constant < Attrio::Types::Base

      string = constant.to_s
      string = string.camelize if (string =~ /\w_\w/ || string[0].downcase == string[0])
      
      begin
        if Attrio::Types.const_defined?(string)
          return Attrio::Types.const_get(string)
        elsif Module.const_defined?(string)
          return Module.const_get(string)
        else
          return nil
        end
      rescue
        return constant
      end
    end

  protected

    def as
      self.options[:as]
    end

    def add_attribute(name, attribute)
      @object.send(self.as)[name.to_sym] = attribute
    end        
  end
end