
module Attrio
  module Collection
    class Set < DelegateClass(::Set)
      def initialize
        @collection = ::Set.new
        super(@collection)
      end
    end
  end
end
