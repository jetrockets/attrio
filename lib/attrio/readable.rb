module Attrio
  module Readable

    def self.included(base)
      base.send(:include, Attrio::Readable::InstanceMethods)
    end

    module InstanceMethods
      def reader_method_name
        @reader_method_name ||= self.accessor_name_from_options(:reader) || self.name
      end


      def reader_visibility
        @reader_visibility ||= self.accessor_visibility_from_options(:reader) || :public
      end

      def instance_variable_name
        @instance_variable_name ||= self.options[:instance_variable_name] || "@#{self.name}"
      end

      def define_reader(klass)
        Attrio::Builders::ReaderBuilder.define(klass, self.type,
          self.options.merge({
            :method_name => self.reader_method_name,
            :method_visibility => self.reader_visibility,
            :instance_variable_name => self.instance_variable_name
          })
        )
        self
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
end