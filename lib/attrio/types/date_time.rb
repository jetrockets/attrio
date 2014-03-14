# encoding: utf-8

module Attrio
  module Types
    class DateTime < Base
      def self.typecast(value, options = {})
        begin
          options[:format].present? ? ::DateTime.strptime(value.to_s, options[:format]) : ::DateTime.parse(value.to_s)
        rescue ArgumentError => e
          nil
        end
      end

      def self.typecasted?(value, options = {})
        value.is_a? ::DateTime
      end
    end
  end
end