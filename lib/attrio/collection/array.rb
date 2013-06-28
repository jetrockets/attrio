module Attrio
  module Collection
    class Array < DelegateClass(::Array)
      def initialize
        @collection = []
        super(@collection)
      end
    end
  end
end

