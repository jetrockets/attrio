# encoding: utf-8

require 'attrio/default_value/base'

module Attrio
  module DefaultValue
    class Symbol < Base
      def self.handle?(value)
        value.is_a?(::Symbol)
      end

      # Evaluates the value via self.object#send(value)
      # Symbol value is returned if the object doesn't respond to value
      #
      # @param [Object] instance
      #      
      def call(instance)
        instance.respond_to?(self.value, true) ? instance.send(self.value) : self.value
      end     
    end
  end
end