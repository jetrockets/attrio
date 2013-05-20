# encoding: utf-8

module Attrio  
  module Types
    class Boolean < Base
      def self._typecast(value, options = {})
        return true if ['yes', '1', 1, 'true', true].include?(value)
        return false
      end

      def self.typecasted?(value)
        value == true || value == false
      end

      def self.default_reader_aliases(method_name)
        super.push("#{method_name}?").flatten.uniq
      end
    end
  end
end