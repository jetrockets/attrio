# encoding: utf-8

module Attrio
  module Types
    class Symbol < Base
      def self._typecast(value, options = {})
        value.underscore.to_sym
      end

      def self.typecasted?(value)
        value.is_a? ::Symbol
      end
    end
  end
end