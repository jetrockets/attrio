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
      attribute_name = args[0].to_s
      attribute_options = (args.last.kind_of?(Hash) ? args.pop : Hash.new)
      attribute_type = self.fetch_type(attribute_options.delete(:type) || args[1])

      attribute = self.create_attribute(attribute_name, attribute_type, attribute_options)
      self.add_attribute(attribute_name, attribute)

      self
    end

    alias_method :attribute, :attr

    def collection(*args)
      collection_name = args[0].to_s
      collection_options = args.last.kind_of?(Hash) ? args.pop : Hash.new
      collection_type = self.fetch_type(collection_options.delete(:type) || args[1])

      collection = self.create_collection(collection_name, collection_type,
                                          collection_options)
      self.add_collection(collection_name, collection)

      self
    end

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

    def c_as
      self.options[:c_as]
    end

    def fetch_type(name)
      return if name.nil?

      type = self.class.cast_type(name)
      self.class.const_missing(name.to_s) if type.blank?

      type
    end

    def create_attribute(name, type, options)
      Attrio::Attribute.new(name, type, options).define_writer(self.klass).define_reader(self.klass)
    end

    def create_collection(name, type, options)
      Attrio::Collection.new(name, type, options).define_collection(self.klass)
    end

    def add_attribute(name, attribute)
      @klass.send(self.as)[name.to_sym] = attribute
    end

    def add_collection(name, collection)
      @klass.send(self.c_as)[name.to_sym] = collection
    end
  end
end