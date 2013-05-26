# encoding: utf-8

module Attrio
  module Types
    class Date < Base
      def self.typecast(value, options = {})
        begin
          options[:format].present? ? ::Date.strptime(value.to_s, options[:format]) : ::Date.parse(value.to_s)
        rescue ArgumentError => e
          nil
        end
      end

      def self.typecasted?(value)
        value.is_a? ::Date
      end
    end
  end
end