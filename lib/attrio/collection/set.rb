
module Attrio
  module Collection
    class Set < DelegateClass(::Set)
      include Attrio::Readable
      include Attrio::Collectable

      def initialize(name, type, options)
        @name = name; @type = type, @options = Helpers.symbolize_hash_keys(options)
        @collection = ::Set.new
        super(@collection)
      end
    end
  end
end
