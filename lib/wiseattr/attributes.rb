# encoding: utf-8

module Wiseattr
  module Attributes
    module Types
      autoload :Base, 'wiseattr/attributes/types/base'
      autoload :Boolean, 'wiseattr/attributes/types/boolean'
      autoload :Date, 'wiseattr/attributes/types/date'
      autoload :DateTime, 'wiseattr/attributes/types/date_time'
      autoload :Float, 'wiseattr/attributes/types/float'
      autoload :Integer, 'wiseattr/attributes/types/integer'
      autoload :Symbol, 'wiseattr/attributes/types/symbol'
      autoload :Time, 'wiseattr/attributes/types/time'
    end

    autoload :ReaderBuilder, 'wiseattr/attributes/reader_builder'
    autoload :WriterBuilder, 'wiseattr/attributes/writer_builder'
  end
end
