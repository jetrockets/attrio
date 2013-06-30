
module Attrio
  module Collections
    class Set < DelegateClass(Set)

      def initialize
        @collection = ::Set.new
        super(@collection)
      end
    end
  end
end
