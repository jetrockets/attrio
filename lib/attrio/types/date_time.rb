# encoding: utf-8

module Attrio
  module Types
    class DateTime < Base
      def self._typecast(value, options = {})
        options[:format].present? ? ::DateTime.strftime(value, options[:format]) : ::DateTime.parse(value)
      end

      def self.typecasted?(value)
        value.is_a? ::DateTime
      end
    end
  end
end