# encoding: utf-8

module Attrio
  module Types
    class Integer < Base
      def self.typecast(value, options = {})
        begin
          return value.to_i(options[:base]) if value.is_a?(String) && options[:base].present? 
          value.to_i
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