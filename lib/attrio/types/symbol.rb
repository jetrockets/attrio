# encoding: utf-8

module Attrio
  module Types
    class Symbol < Base
      def self.typecast(value, options = {})
        begin
          value = value.underscore if options[:underscore].present?
          value.to_sym
        rescue NoMethodError => e
          nil
        end
      end

      def self.typecasted?(value, options = {})
        value.is_a? ::Symbol
      end
    end
  end
end