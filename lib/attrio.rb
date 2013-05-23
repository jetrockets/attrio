# encoding: utf-8

require 'attrio/version'

require 'attrio/core_ext/array'
require 'attrio/core_ext/class'
require 'attrio/core_ext/hash'
require 'attrio/core_ext/object'
require 'attrio/core_ext/string'

module Attrio
  autoload :AttributesParser, 'attrio/attributes_parser'
  autoload :Attribute, 'attrio/attribute'
  autoload :Initialize, 'attrio/initialize'
  autoload :Inspect, 'attrio/inspect'
  autoload :Reset, 'attrio/reset'

  def self.included(base)    
    base.send(:include, Attrio::Initialize)
    base.send(:include, Attrio::Inspect)
    base.send(:include, Attrio::Reset)

    base.send(:extend, Attrio::ClassMethods)    
  end

  module ClassMethods
    def define_attributes(options = {}, &block)
      options[:as] ||= :attributes
      
      cattr_accessor options[:as].to_sym
      class_eval(<<-EOS)
        @@#{options[:as].to_s} ||= {}
      EOS

      self.define_attrio_new(options[:as])
      self.define_attrio_reset(options[:as])
      self.define_attrio_inspect(options[:as]) unless options[:inspect] == false

      Attrio::AttributesParser.new(self, options, &block)
    end

    def const_missing(name)
      Attrio::AttributesParser.cast_type(name) || super
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