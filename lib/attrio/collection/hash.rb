
module Attrio
  module Collection
    class Hash < DelegateClass(::Hash)
      def initialize
        @collection = {}
        super(@collection)
      end
    end
  end
end

