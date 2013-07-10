module Attrio
  module Builders
    class CollectionBuilder
      def self.define_collection(klass, type, options)
        self.define_collection_reader(klass, type, options)
        self.define_collection_add(klass, options)
        self.define_collection_find(klass, options)
        self.define_collection_include(klass, options)
        self.define_collection_reset(klass, options)
        self.define_collection_initialize(klass, options)
        self.define_collection_empty(klass, options)
      end

      #TODO REVIEW using a guard clause instead of an unless block
      def self.define_collection_reader(klass, type, options)
        return if klass.method_defined?(options[:method_name])
        klass.send :define_method, options[:method_name] do
          if instance_variable_defined?(options[:instance_variable_name])
            return instance_variable_get(options[:instance_variable_name])
          else
            return instance_variable_set(options[:instance_variable_name], options[:container].create_collection(type, options))
          end
        end
      end

      def self.define_collection_add(klass, options)
        klass.send :extend, Forwardable
        self.set_delegate(klass, :add_element, options)
      end

      def self.define_collection_find(klass, options)
        self.set_delegate(klass, :find_element, options)
      end

      def self.define_collection_include(klass, options)
        self.set_delegate(klass, :has_element?, options)
      end

      def self.define_collection_reset(klass, options)
        self.set_delegate(klass, :reset_collection, options)
      end

      def self.define_collection_initialize(klass, options)
        self.set_delegate(klass, :initialize_collection, options)
      end

      def self.define_collection_empty(klass, options)
        self.set_delegate(klass, :empty_collection, options)
      end

      def self.set_delegate(klass, name, options)
        my_name = name.to_s.sub("?","").<<("_name").to_sym
        visibility = name.to_s.sub("?","").<<("_visibility").to_sym
        self.define_delegate(klass, options[:method_name], name, options[my_name], options[visibility])

      end

      def self.define_delegate(klass, obj, obj_method, my_name, visibility)
        klass.send :def_delegator, obj, obj_method, my_name
        klass.send visibility, my_name
      end
    end
  end
end