module Attrio
  module Collections
    class Set < DelegateClass(Set)
      include Attrio::Collections::Common

      def initialize(type, options)
        @type       = type, @options = options
        @collection = ::Set.new
        super(@collection)
      end
    end
  end
end
