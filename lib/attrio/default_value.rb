# encoding: utf-8

module Attrio
  module DefaultValue
    autoload :Base, 'attrio/default_value/base'
    autoload :Callable, 'attrio/default_value/callable'
    autoload :Clonable, 'attrio/default_value/clonable'
    autoload :Symbol, 'attrio/default_value/symbol'

    class << self
      def new(attribute, value)
        Attrio::DefaultValue::Base.handle(attribute, value) || value
      end
    end
  end
end