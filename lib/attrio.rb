# encoding: utf-8

require 'attrio/version'

require 'attrio/core_ext/array'
require 'attrio/core_ext/class'
require 'attrio/core_ext/hash'
require 'attrio/core_ext/object'
require 'attrio/core_ext/string'

module Attrio
  autoload :Attributes, 'attrio/attributes'
  autoload :Inspect, 'attrio/inspect'

  def self.included(base)    
    base.send(:extend, Attrio::ClassMethods)
  end

  module ClassMethods
    def define_attributes(options = {}, &block)
      options[:as] ||= :attributes
      
      cattr_accessor options[:as].to_sym
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        @@#{options[:as].to_s} ||= {}
      EOS

      unless options[:inspect] == false
        self.send :include, Attrio::Inspect
      end

      Attrio::Attributes.new(self, options, &block)
    end

    def const_missing(name)
      Attrio::Attributes.cast_type(name) || super
    end
  end

  module Builders
    autoload :ReaderBuilder, 'attrio/builders/reader_builder'
    autoload :WriterBuilder, 'attrio/builders/writer_builder'
  end

  module Types
    autoload :Base, 'attrio/types/base'
    autoload :Boolean, 'attrio/types/boolean'
    autoload :Date, 'attrio/types/date'
    autoload :DateTime, 'attrio/types/date_time'
    autoload :Float, 'attrio/types/float'
    autoload :Integer, 'attrio/types/integer'
    autoload :Symbol, 'attrio/types/symbol'
    autoload :Time, 'attrio/types/time'
  end
end