# encoding: utf-8

module Attrio
  module Types
    class Time < Base
      def self.typecast(value, options = {})
        options[:format].present? ? ::Time.strftime(value, options[:format]) : ::Time.parse(value)
      end

      def self.typecasted?(value)
        value.is_a? ::Time
      end
    end
  end
end