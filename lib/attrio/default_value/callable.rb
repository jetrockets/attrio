# encoding: utf-8

require 'attrio/default_value/base'

module Attrio
  module DefaultValue
    class Callable < Base
      def self.handle?(value)
        value.respond_to?(:call)
      end

      # Evaluates the value via value#call
      #
      # @param [Object] instance
      #
      # @return [Object] evaluated value
      #
      def call(instance)
        self.value.call(instance, self.attribute)
      end
    end
  end
end