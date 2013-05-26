# encoding: utf-8

module Attrio
  module Types
    class Time < Base
      def self.typecast(value, options = {})
        begin
          options[:format].present? ? ::Time.strptime(value.to_s, options[:format]) : ::Time.parse(value.to_s)
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