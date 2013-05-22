# encoding: utf-8

module Attrio
  module Types
    class DateTime < Base
      def self.typecast(value, options = {})
        begin
          options[:format].present? ? ::DateTime.strptime(value, options[:format]) : ::DateTime.parse(value)
        rescue ArgumentError => e
          nil
        end
      end

      def self.typecasted?(value)
        value.is_a? ::DateTime
      end
    end
  end
end