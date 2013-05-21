# encoding: utf-8

module Attrio
  class Attributes
    attr_reader :klass, :options

    def initialize(object, options, &block)
      @object = object
      @options = options

      raise ArgumentError.new('Missing options[:as] value' ) if @options[:as].blank?

      self.instance_eval(&block)
    end

    def attr(*args)
      options = args.extract_options!
      type = options.delete(:type) || args[1]
      attribute_name = args[0].to_s

      casted_type = self.class.cast_type(type)
      self.class.const_missing(type.to_s) if casted_type.blank?

      reader_builder = Attrio::Builders::ReaderBuilder.new(@object, attribute_name, casted_type, options)
      writer_builder = Attrio::Builders::WriterBuilder.new(@object, attribute_name, casted_type, options)
      self.add_attribute(attribute_name, reader_builder, writer_builder)

      reader_builder.define_method.define_aliases
      writer_builder.define_method.define_aliases
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

    def add_attribute(attribute_name, reader_builder, writer_builder)
      @object.send(self.options[:as])[attribute_name.to_sym] = {
        :reader_name => reader_builder.method_name,
        :writer_name => writer_builder.method_name,
        :instance_variable_name => writer_builder.instance_variable_name,
        :default_value => writer_builder.default_value
      }
    end
  end
end