# encoding: utf-8

module Attrio
  module Types
    class Time < Base
      def self.typecast(value, options = {})
        begin
          options[:format].present? ? ::Time.strptime(value, options[:format]) : ::Time.parse(value)
        rescue ArgumentError => e
          nil
        end      
      end

      def self.typecasted?(value)
        value.is_a? ::Time
      end
    end
  end
end