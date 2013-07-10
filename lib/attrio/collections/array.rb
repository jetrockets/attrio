module Attrio
  module Collections
    class Array < SimpleDelegator
      include Attrio::Collections::Common

      def initialize
        @collection = __mk_empty_collection__
        super(@collection)
        @collection
      end

      def add_element(*values)
        #binding.pry
        values.flatten!
        #TODO should we skip values that can't be coerced into type?
        #TODO should we raise our own exception if any value is not of correct type?
        values.each do |new_val|
          next if new_val.nil?
          #TODO should there be functionality to address assigning a duplicate?
          self << __normalize_value__(new_val)
        end
        self
      end

      private
      def __mk_empty_collection__
        []
      end

    end
  end
end

