module Attrio
  module Collections
    class Array < DelegateClass(Array)
      def initialize
        @collection = []
        super(@collection)
      end


    end
  end
end

