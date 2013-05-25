# encoding: utf-8

require 'attrio/default_value/base'

module Attrio
  module DefaultValue
    class Symbol < Base
        def self.handle?(value)
          value.is_a?(::Symbol)
        end

        # Evaluates the value via instance#public_send(value)
        #
        # Symbol value is returned if the instance doesn't respond to value
        #
        # @return [Object] evaluated value
        #
        def call(instance, *)
          instance.respond_to?(@value, true) ? instance.send(@value) : @value
        end
      
    end
  end
end