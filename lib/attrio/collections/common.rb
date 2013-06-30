module Attrio
  module Collections
    module Common
      def self.included(base)
        base.send :attr_reader, :type, :options
      end

      def kind_of?(klass)
        return true if klass == ::Hash
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

      def add_element(*args)
        raise NotImplementedError
      end

      def has_element?(raw_element)
        @collection.include?(type_cast(raw_element))
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
          @collection.detect{|e| e == value}
        else
          #TODO expand to return default if no element matches
          nil
        end
      end
    end
  end
end