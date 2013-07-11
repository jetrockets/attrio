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
  autoload :Readable, 'attrio/readable'

  def self.included(base)
    base.send :include, Attrio::Initialize
    base.send :include, Attrio::Inspect
    base.send :include, Attrio::Reset

    base.send :extend, Attrio::ClassMethods
  end

  module ClassMethods
    def define_attributes(options = {}, &block)
      options[:as] ||= :attributes
      options[:c_as] ||= options[:collections_as] || :collections
      
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)        
        @#{options[:as]} ||= {}
        @#{options[:c_as]} ||= {}

        class << self
          def #{options[:as]}(attributes = [])
            attributes = Helpers.to_a(attributes).flatten
            return @#{options[:as]} if attributes.empty?

            attributes = @#{options[:as]}.keys & attributes
            @#{options[:as]}.select{ |k,v| attributes.include?(k) }          
          end

          def #{options[:c_as]}(collections = [])
            collections = Helpers.to_a(collections).flatten
            return @#{options[:c_as]} if collections.empty?

            collections = @#{options[:c_as]}.keys & collections
            @#{options[:c_as]}.select{ |k,v| collections.include?(k)}
          end

          def inherited(subclass)
            subclass.instance_variable_set("@#{options[:as]}", instance_variable_get("@#{options[:as]}").dup)
            subclass.instance_variable_set("@#{options[:c_as]}", instance_variable_get("@#{options[:c_as]}").dup)
          end
        end

        def #{options[:as]}(attributes = [])
          self.class.#{options[:as]}(attributes)
        end

        def #{options[:c_as]}(collections = [])
          self.class.#{options[:c_as]}(collections)
        end
      EOS

      self.define_attrio_new(options[:as])
      self.define_attrio_reset(options[:as])
      self.define_attrio_inspect(options[:as],options[:c_as]) unless options[:inspect] == false

      Attrio::AttributesParser.new(self, options, &block)
      self.define_attrio_collection_reset(options[:c_as])

    end

    def const_missing(name)
      Attrio::AttributesParser.cast_type(name) || super
    end
  end

  autoload :Attribute, 'attrio/attribute'
  autoload :Collection, 'attrio/collection'
  autoload :DefaultValue, 'attrio/default_value'

  module Builders
    autoload :ReaderBuilder, 'attrio/builders/reader_builder'
    autoload :WriterBuilder, 'attrio/builders/writer_builder'
    autoload :CollectionBuilder, 'attrio/builders/collection_builder'
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

  module Collections
    autoload :Common, 'attrio/collections/common'
    autoload :Array, 'attrio/collections/array'
    autoload :Hash, 'attrio/collections/hash'
    autoload :Set, 'attrio/collections/set'
  end

end
