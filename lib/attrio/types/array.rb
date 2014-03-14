# encoding: utf-8

module Attrio
  module Types
    class Array < Base
      def self.typecast(value, options = {})
        begin
          array = (!value.is_a?(::Array) && value.respond_to?(:split)) ? value.split(options[:split]): Attrio::Helpers.to_a(value).flatten
          if options[:element].present?

            type = Attrio::AttributesParser.cast_type(self.element_type(options[:element]))
            options = self.element_options(options[:element])

            array.map! do |item|
              if type.respond_to?(:typecast) && type.respond_to?(:typecasted?)
                type.typecasted?(item) ? item : type.typecast(item, options)
              else
                type == Hash && item.is_a?(Hash) ? value : type.new(item)
              end
            end
          end

          array
        rescue ArgumentError => e
          nil
        end
      end

      def self.typecasted?(value, options = {})
        if options[:element].present?
          type = Attrio::AttributesParser.cast_type(self.element_type(options[:element]))
          value.is_a?(::Array) && !value.any?{ |e| !e.is_a?(type) }
        else
          value.is_a?(::Array)
        end
      end

    protected

      def self.element_type(element)
        element[:type]
      rescue
        element
      end

      def self.element_options(element)
        element[:options] || {}
      rescue
        {}
      end
    end
  end
end