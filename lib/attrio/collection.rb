# encoding: utf-8

module Attrio
  class Collection
    include ::Attrio::Readable

    def initialize(name, type, options)
      @name = name; @type = type; @options = Helpers.symbolize_hash_keys(options)
    end

    def define_collection(klass)
      Attrio::Builders::CollectionBuilder.define_collection(klass, self.type,
        self.options.merge({
          :container => self.container_type,
          :method_name => self.reader_method_name,
          :method_visibility => self.reader_visibility,
          :instance_variable_name => self.instance_variable_name,
          :add_element_name => self.add_element_name,
          :add_element_visibility => self.add_element_visibility,
          :find_element_name => self.find_element_name,
          :find_element_visibility => self.find_element_visibility,
          :has_element_name => self.has_element_name,
          :has_element_visibility => self.has_element_visibility
        })
      )
      self
    end

    def add_element_name
      @add_element_name ||= self.accessor_name_from_options(:add_element) || "add_#{self.name}"
    end

    def add_element_visibility
      @add_element_visibility ||= self.accessor_visibility_from_options(:add_element) || :public
    end

    def find_element_name
      @find_element_name ||= self.accessor_name_from_options(:find_element) || "find_#{self.name}"
    end

    def find_element_visibility
      @find_element_visibility ||= self.accessor_visibility_from_options(:find_element) || :public
    end

    def has_element_name
      @has_element_name ||= self.accessor_name_from_options(:has_element) || "has_#{self.name}?"
    end

    def has_element_visibility
      @has_element_visibility ||= self.accessor_visibility_from_options(:has_element) || :public
    end

    protected
    def container_type
      return Attrio::Collections::Hash if options.fetch(:unique, false) && options.fetch(:index, nil)
      return Attrio::Collections::Set if options.fetch(:unique, false)
      return Attrio::Collections::Array
    end
  end
end