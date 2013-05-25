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
      # @param [Object] args
      #
      # @return [Object] evaluated value
      #
      def call(*args)
        self.value.call(*args)
      end    
    end
  end
end