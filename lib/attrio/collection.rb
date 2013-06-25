# encoding: utf-8

#TODO should behavior common to both Collection and Attribute be refactored out into a base class?

module Attrio
  class Collection
    attr_reader :name, :container, :type, :options

    def initialize(name, container, type, options)
      @name = name; @container = container; @type = type, @options = Helpers.symbolize_keys(options)
    end

    def collection_reader_name
      @collection_reader_name ||= self.accessor_name_from_options(:collection_reader) || self.name
    end

    def collection_reader_visibility
      @collection_reader_visibility ||= self.accessor_visibility_from_options(:collection_reader) || :public
    end

    def add_element_name
      @add_element_name ||= self.accessor_name_from_options(:add_element) || "add_#{self.name}"
    end

    def add_element_visibility
      @add_element_visibility ||= self.accessor_visibility_from_options(:add_element) || :public
    end

    def find_element_name
      @add_element_name ||= self.accessor_name_from_options(:find_element) || "find_#{self.name}"
    end

    def find_element_visibility
      @add_element_visibility ||= self.accessor_visibility_from_options(:find_element) || :public
    end

    def instance_variable_name
      @instance_variable_name ||= self.options[:instance_variable_name] || "@#{self.name}"
    end

    def default_value
      if !defined?(@default_value)
        @default_value = Attrio::DefaultValue.new(self.name, self.options[:default])
      end
      @default_value
    end

    def define_reader(klass)
      #TODO complete after creating Attrio::Builders::CollectionAddElementBuilder
    end

    def define_add_element(klass)
      #TODO complete after creating Attrio::Builders::CollectionAddElementBuilder
    end

    def define_find_element(klass)
      #TODO complete after creating Attrio::Builders::CollectionAddElementBuilder
    end

    protected
      def accessor_name_from_options(accessor)
        (self.options[accessor.to_sym].is_a?(Hash) && self.options[accessor.to_sym][:name]) || self.options["#{accessor.to_s}_name".to_sym]
      end

      def accessor_visibility_from_options(accessor)
        return self.options[accessor] if self.options[accessor].present? && [:public, :protected, :private].include?(self.options[accessor])
        (self.options[accessor].is_a?(Hash) && self.options[accessor][:visibility]) || self.options["#{accessor.to_s}_visibility".to_sym]
      end

  end
end

#* type
#* collection reader name
#* collection reader visibility
#* add element method name
#* add element method visibility
#* find element method name
#* find element method visibility
#* instance variable name
#* additional options
