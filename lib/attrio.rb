# encoding: utf-8

require 'attrio/version'

require 'attrio/core_ext/object'
require 'attrio/core_ext/string'

module Attrio
  autoload :AttributesParser, 'attrio/attributes_parser'
  autoload :Initialize, 'attrio/initialize'
  autoload :Inspect, 'attrio/inspect'
  autoload :Reset, 'attrio/reset'
  autoload :Helpers, 'attrio/helpers'

  def self.included(base)
    base.send :include, Attrio::Reset
    base.send :include, Attrio::Inspect

    base.send :extend, Attrio::Initialize
    base.send :extend, Attrio::ClassMethods
  end

  module ClassMethods
    def attrio
      @attrio ||= {}
    end

    def define_attributes(options = {}, &block)
      as = options.delete(:as) || :attributes
      self.attrio[as] = options

      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        @#{as} ||= {}

        class << self
          def #{as}(attributes = [])
            attributes = Helpers.to_a(attributes).flatten
            return @#{as} if attributes.empty?

            attributes = @#{as}.keys & attributes
            @#{as}.select{ |k,v| attributes.include?(k) }
          end

          def inherited(subclass)
            subclass.instance_variable_set("@#{as}", instance_variable_get("@#{as}").dup)
          end
        end

        def #{as}(attributes = [])
          # self.class.#{as}(attributes)

          attributes = Helpers.to_a(attributes).flatten
          return @#{as} if attributes.empty?

          attributes = @#{as}.keys & attributes
          @#{as}.select{ |k,v| attributes.include?(k) }
        end
      EOS

      self.define_attrio_reset(as)

      Attrio::AttributesParser.new(self, as, &block)
    end

    def const_missing(name)
      Attrio::AttributesParser.cast_type(name) || super
    end
  end

  autoload :Attribute, 'attrio/attribute'
  autoload :DefaultValue, 'attrio/default_value'

  module Builders
    autoload :ReaderBuilder, 'attrio/builders/reader_builder'
    autoload :WriterBuilder, 'attrio/builders/writer_builder'
  end

  module Types
    autoload :Array, 'attrio/types/array'
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
