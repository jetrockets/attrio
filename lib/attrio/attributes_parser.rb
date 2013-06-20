# encoding: utf-8

module Attrio
  class AttributesParser
    attr_reader :klass, :options

    def initialize(klass, options, &block)
      @klass = klass
      @options = options

      raise ArgumentError.new('Missing options[:as] value' ) if @options[:as].blank?

      self.instance_eval(&block)
    end

    def attr(*args)
      attribute_options = (args.last.kind_of?(Hash) ? args.pop : Hash.new)
      attribute_name = args[0].to_s

      type = self.class.cast_type(attribute_options.delete(:type) || args[1])      
      self.class.const_missing(attribute_options.delete(:type).to_s || args[1].to_s) if type.blank?

      attribute = Attrio::Attribute.new(attribute_name, type, attribute_options).define_writer(@klass).define_reader(@klass)
      self.add_attribute(attribute_name, attribute)
    end

    alias_method :attribute, :attr

    def self.cast_type(constant)
      return constant if constant.is_a?(Class) && !!(constant < Attrio::Types::Base)

      string = constant.to_s
      string = string.camelize if (string =~ /\w_\w/ || string.chars.first.downcase == string.chars.first)
      
      begin
        if Attrio::Types.const_defined?(string)
          return Attrio::Types.const_get(string)
        elsif Object.const_defined?(string)
          return Object.const_get(string)
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
      @klass.send(self.as)[name.to_sym] = attribute
    end        
  end
end