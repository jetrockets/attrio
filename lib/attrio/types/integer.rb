# encoding: utf-8

module Attrio
  module Types
    class Integer < Base
      def self._typecast(value, options = {})
        value.to_i
      end

      def self.typecasted?(value)
        value.id_a? ::Integer
      end
    end
  end
end