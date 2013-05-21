# encoding: utf-8

module Attrio  
  module Types
    class Boolean < Base
      def self._typecast(value, options = {})
        return true if ['yes', '1', 1, 'true'].include?(value)
        return false
      end

      def self.typecasted?(value)
        value.is_a?(TrueClass) || value.is_a?(FalseClass)
      end

      def self.default_reader_aliases(method_name)
        super.push("#{method_name}?").flatten.uniq
      end
    end
  end
end