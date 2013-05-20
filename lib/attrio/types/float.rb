# encoding: utf-8

module Attrio
  module Types
    class Float < Base
      def self._typecast(value, options = {})
        value.to_f
      end

      def self.typecasted?(value)
        value.is_a? ::Float
      end
    end
  end
end