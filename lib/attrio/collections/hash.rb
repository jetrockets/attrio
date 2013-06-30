# encoding: utf-8

module Attrio
  module Collections
    class Hash < DelegateClass(Hash)
      include Attrio::Collections::Common

      attr_reader :type, :key_method, :options

      def initialize(type, options = {})
        @type       = type; @options = options
        @key_method = options[:key_method] || :hash
        @collection = {}
        super(@collection)
        self
      end

      def add_element(*values)
        #TODO should we skip values that can't be coerced into type?
        #TODO should we raise our own exception if any value is not of correct type?
        values.each do |new_val|
          next if new_val.nil?
          value            = type_cast(new_val)
          #TODO should there be functionality to address assigning a new value to an existing key?
          key              = value.send(key_method)
          @collection[key] = value
        end
        @collection
      end

      def has_element?(key)
        @collection.has_key?(key)
      end

      def find_element(key)
         #TODO expand to return default if no element matches
        @collection.fetch(key, nil)
      end
    end
  end
end

