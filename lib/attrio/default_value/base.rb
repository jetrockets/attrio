# encoding: utf-8

module Attrio
  module DefaultValue
    class Base
      attr_reader :object, :value

      def self.handle(object, value)
        klass = [
          Attrio::DefaultValue::Callable,
          Attrio::DefaultValue::Clonable,
          Attrio::DefaultValue::Symbol
        ].detect{ |klass| klass.handle?(value) }

        klass.new(object, value) if klass.present?
      end

      def initialize(object, value)
        @object = object; @value = value
      end

      # Evaluates the value      
      # @return [Object] evaluated value
      #      
      def call(*)
        raise NotImplementedError
      end
    end
  end
end