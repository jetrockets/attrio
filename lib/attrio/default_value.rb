# encoding: utf-8

module Attrio
  module DefaultValue
    autoload :Base, 'attrio/default_value/base'
    autoload :Callable, 'attrio/default_value/callable'
    autoload :Clonable, 'attrio/default_value/clonable'
    autoload :Symbol, 'attrio/default_value/symbol'

    class << self      
      def new(object, value)
        Attrio::DefaultValue::Base.handle(object, value) || value
      end
    end
  end
end