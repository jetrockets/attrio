module Attrio
  module Collections
    module Common
      def included(base)
        base.send :attr_reader, :type, :options
      end

      def kind_of?(klass)
        return true if klass == ::Hash
        super(klass)
      end

      def type_cast(value)
        if type.respond_to?(:typecast) && type.respond_to?(:typecasted?)
          type.typecasted?(value) ? value : type.typecast(*[value, options])
        else
          type.new(value)
        end
      end

      def add_element(*args)
        raise NotImplementedError
      end

    end
  end
end