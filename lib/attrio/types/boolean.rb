# encoding: utf-8

module Attrio  
  module Types
    class Boolean < Base
      def self.typecast(value, options = {})
        true_values = options[:true] || options[:true_values] || ['yes', '1', 1, 'true']
        false_values = options[:false] || options[:false_values]

        if false_values.present?
          return Array.wrap(false_values).flatten.include?(value) ? false : true
        else
          return Array.wrap(true_values).flatten.include?(value) ? true : false
        end        
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