module Attrio
  module Builders
    class CollectionBuilder
      def self.define_collection(klass, type, options)
        self.define_collection_reader(klass, type, options)
      end

      #TODO REVIEW using a guard clause instead of an unless block
      def self.define_collection_reader(klass, type, options)
        return if klass.method_defined?(options[:method_name])
        klass.send define_method, options[:method_name] do
          if instance_variable_defined?(options[:instance_variable_name])
            return instance_variable_get(options[:instance_variable_name])
          else
            return instance_variable_set(options[:instance_variable_name], options[:container].new)
          end
        end
      end

      def self.define_collection_add(klass, options)
        klass.send :extend, Forwardable
        klass.send :def_delegator, options[:instance_variable_name], :add_element, options[:add_element_name]
        klass.send options[:add_element_visibility], options[:add_element_name]
      end

      def self.define_collection_find

      end

      def self.define_collection_include

      end

    end
  end
end