module Attrio
  module Collections
    class Array < DelegateClass(Array)
      include Attrio::Collections::Common

      def initialize(type, options)
        @type       = type, @options = options
        @collection = []
        super(@collection)
      end


    end
  end
end

