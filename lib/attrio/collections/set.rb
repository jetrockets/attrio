module Attrio
  module Collections
    class Set < DelegateClass(Set)
      include Attrio::Collections::Common

      def initialize(type, options)
        @type       = type; @options = options
        @collection = ::Set.new
        super(@collection)
      end

      def add_element(*values)
        #TODO should we skip values that can't be coerced into type?
        #TODO should we raise our own exception if any value is not of correct type?
        values.each do |new_val|
          next if new_val.nil?
          value            = type_cast(new_val)
          #TODO should there be functionality to address assigning a duplicate?
          @collection << value
        end
        @collection
      end
    end
  end
end
