# encoding: utf-8

module Attrio
  module Types
    class Integer < Base
      def self.typecast(value, options = {})
        base = options.is_a?(Hash) && options[:base] ? options[:base] : 10
        
        begin
          return value.to_i(base) if value.is_a?(String)
          return value.to_i
        rescue NoMethodError => e
          nil
        end
      end

      def self.typecasted?(value)
        value.is_a? ::Integer
      end
    end
  end
end