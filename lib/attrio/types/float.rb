# encoding: utf-8

module Attrio
  module Types
    class Float < Base
      def self.typecast(value, options = {})
        begin
          value.to_f
        rescue NoMethodError => e
          nil
        end
      end

      def self.typecasted?(value, options = {})
        value.is_a? ::Float
      end
    end
  end
end