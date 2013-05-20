# encoding: utf-8

module Attrio
  module Types
    class Base < Object        
      private_class_method :new

      def self.typecast(value, options = {})
        self.typecasted?(value) ? value : self._typecast(value, options)
      end

      def self._typecast(value, options = {})
        raise NotImplementedError
      end

      def self.typecasted?(value)
        false
      end

      def self.default_reader_aliases(method_name)
        []
      end

      def self.default_writer_aliases(method_name)
        []
      end
    end
  end
end