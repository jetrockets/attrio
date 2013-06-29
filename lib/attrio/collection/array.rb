module Attrio
  module Collection
    class Array < DelegateClass(::Array)
      include Attrio::Readable
      include Attrio::Collectable

      def initialize(name, type, options)
        @name = name; @type = type, @options = Helpers.symbolize_hash_keys(options)
        @collection = []
        super(@collection)
      end


    end
  end
end

