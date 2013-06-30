# encoding: utf-8

module Attrio
  module Collections
    class Hash < DelegateClass(Hash)
      attr_reader :type, :key_method, :options

      def initialize(type,options = {})
        @type = type
        @key_method = options[:key_method] || :hash
        @options = options
        @collection = {}
        super(@collection)
        self
      end

      def add_element(*values)
        #TODO should we skip values that can't be coerced into type?
        #TODO should we raise our own exception if any value is not of correct type?
        values.each do |new_val|
          next if new_val.nil?
          value = type_cast(new_val)
          #TODO should there be functionality to address assigning a new value to an existing key?
          key = value.send(key_method)
          @collection[key] = value
        end
        @collection
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
    end
  end
end

