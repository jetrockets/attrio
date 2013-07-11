# encoding: utf-8

module Attrio
  module Collections
    class Hash < SimpleDelegator
      include Attrio::Collections::Common

      attr_reader :type, :options

      def initialize
        @collection = __mk_empty_collection__
        super(@collection)
      end

      def add_element(*values)
        values.flatten!
        #TODO should we skip values that can't be coerced into type?
        #TODO should we raise our own exception if any value is not of correct type?
        values.each do |new_val|
          next if new_val.nil?
          value =  __normalize_value__(new_val)

          #TODO should there be functionality to address assigning a new value to an existing key?
          key              = value.send(index_method)
          self[key] = value
        end
        self
      end

      def has_element?(key)
        self.has_key?(key)
      end

      def find_element(key)
         #TODO expand to return default if no element matchesa.samples.c
        self.fetch(key, nil)
      end

      def index_method
        @index_method ||= options[:index]
      end

      private
      def __mk_empty_collection__
        {}
      end
    end
  end
end

#b = Attrio::Collection.new(:samples, String, unique: true, index: :chr);class TestMe; end; b.define_collection(TestMe);a = TestMe.new
