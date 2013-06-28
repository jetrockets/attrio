# encoding: utf-8

module Attrio
  class Attribute
    include ::Attrio::AttributeBase

    attr_reader :name, :type, :options

    def initialize(name, type, options)
      @name = name; @type = type; @options = Helpers.symbolize_hash_keys(options)
    end


    def writer_method_name
      @writer_method_name ||= self.accessor_name_from_options(:writer) || "#{self.name}="
    end

    def writer_visibility
      @writer_visibility ||= self.accessor_name_from_options(:writer) || :public
    end


    def default_value
      if !defined?(@default_value)
        @default_value = Attrio::DefaultValue.new(self.name, self.options[:default])
      end
      @default_value
    end


    def define_writer(klass)
      Attrio::Builders::WriterBuilder.define(klass, self.type,
        self.options.merge({
          :method_name => self.writer_method_name,
          :method_visibility => self.writer_visibility,
          :instance_variable_name => self.instance_variable_name
        })
      )
      self
    end
  end
end
