# encoding: utf-8

module Attrio
  module DefaultValue
    class Base
      attr_reader :klass, :attribute, :value

      def self.handle(klass, attribute, value)
        handler = [
          Attrio::DefaultValue::Callable,
          Attrio::DefaultValue::Clonable,
          Attrio::DefaultValue::Symbol
        ].detect{ |handler| handler.handle?(value) }

        handler.new(klass, attribute, value) if handler.present?
      end

      def initialize(klass, attribute, value)
        @klass = klass; @attribute = attribute; @value = value;
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