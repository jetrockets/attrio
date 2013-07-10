module Attrio
  module Collections
    module Common
      def self.included(base)
        base.send :attr_reader, :type, :options
        base.extend ClassMethods
      end

      def kind_of?(klass)
        return true if klass == @collection.class
        super(klass)
      end

      def type_cast(value)
        return value if value.is_a?(type)
        if type.respond_to?(:typecast) && type.respond_to?(:typecasted?)
          type.typecasted?(value) ? value : type.typecast(*[value, options])
        else
          type.new(value)
        end
      end

      def initial_values
        return unless options
        if !defined?(@initial_values)
          @initial_values = []
          Helpers.to_a(options[:initial_values]).each do |val|
            #TODO figure out what the attribute(:wtf) does when passed
            @initial_values << Attrio::DefaultValue.new(:wtf, val)
          end
        end
        @initial_values
      end

      def reset_collection
        empty_collection
        initialize_collection
      end

      def add_element(*args)
        raise NotImplementedError
      end

      def initialize_collection
        values = []
        initial_values.each do |val|
          new_val = val.is_a?(Attrio::DefaultValue::Base) ? val.call(self) : val
          values << new_val
        end
        self.add_element(*values)
        self
      end

      def empty_collection
        self.__setobj__(__mk_empty_collection__)
      end

      def __mk_empty_collection__
        raise NotImplementedError
      end

      def has_element?(raw_element)
        self.include?(type_cast(raw_element))
      #TODO review.  Added this catch because any element that can't be type_cast into the right type will never
      # be member of the set
      rescue TypeError
        return false
      end

      #TODO Many possibilities for more advanced find
      #TODO Is there any reason to include an option or alternate syntax for finding all elements
      # that match for an array?


      def find_element(raw_element)
        value = type_cast(raw_element)
        if self.has_element?(value)
          self.detect{|e| e == value}
        else
          #TODO expand to return default if no element matches
          nil
        end
      end

      protected
      def __normalize_value__(new_val)
        if new_val.is_a?(Attrio::DefaultValue::Base)
          return new_val.call(self)
        else
          return type_cast(new_val)
        end
      end


      module ClassMethods
        def create_collection(type, options = {})
          collection = self.new
          collection.instance_variable_set(:@type, type)
          collection.instance_variable_set(:@options, options)
          collection.initialize_collection
          collection
        end

      end
    end
  end
end