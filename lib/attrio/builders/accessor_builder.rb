# encoding: utf-8

module Attrio
  module Builders
    class AccessorBuilder

      attr_reader :object, :attribute_name, :type, :options

      def initialize(object, attribute_name, type, options = {})
        @object = object
        @attribute_name = attribute_name
        @type = type

        @options = options.symbolize_keys        
      end

      def accessor
        raise NotImplementedError
      end

      def method_name
        raise NotImplementedError
      end

      def define_method
        raise NotImplementedError
      end

      def define_aliases          
        if self.type.respond_to?("default_#{self.accessor.to_s}_aliases")
          self.type.send("default_#{self.accessor.to_s}_aliases", self.method_name).each do |alias_method_name|
            self.object.send(:alias_method, alias_method_name, self.method_name)
          end
        end
      end

      def method_visibility_from_options
        return self.options[self.accessor] if self.options[self.accessor].present? && [:public, :protected, :private].include?(self.options[self.accessor])          
        (self.options[self.accessor].is_a?(Hash) && self.options[self.accessor][:visibility]) || self.options["#{self.accessor.to_s}_visibility".to_sym]
      end

      def method_visibility
        self.method_visibility_from_options || :public
      end

      def method_name_from_options
        (self.options[self.accessor].is_a?(Hash) && self.options[self.accessor][:name]) || self.options["#{self.accessor.to_s}_name".to_sym]
      end

      def instance_variable_name
        self.options[:instance_variable_name] || "@#{self.attribute_name}"
      end
    end
  end
end