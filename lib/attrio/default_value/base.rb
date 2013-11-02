# encoding: utf-8

module Attrio
  module DefaultValue
    class Base
      attr_reader :attribute, :value

      def self.handle(attribute, value)
        handler = [
          Attrio::DefaultValue::Callable,
          Attrio::DefaultValue::Clonable,
          Attrio::DefaultValue::Symbol
        ].detect{ |handler| handler.handle?(value) }

        handler.new(attribute, value) if handler.present?
      end

      def initialize(attribute, value)
        @attribute = attribute; @value = value;
      end

      # Evaluates the value
      # @return [Object] evaluated value
      #
      def call(instance)
        raise NotImplementedError
      end
    end
  end
end