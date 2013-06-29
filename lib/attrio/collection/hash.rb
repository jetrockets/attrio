# encoding: utf-8

module Attrio
  module Collection
    class Hash < DelegateClass(::Hash)
      include Attrio::Readable
      include Attrio::Collectable


      def initialize(name, type, options)
        @name = name; @type = type, @options = Helpers.symbolize_hash_keys(options)
        @collection = {}
        super(@collection)
      end
    end
  end
end

