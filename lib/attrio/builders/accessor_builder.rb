# encoding: utf-8

module Attrio
  module Builders
    class AccessorBuilder
      def self.accessor
        raise NotImplementedError
      end

      def self.define(object, type, options)
        self.define_accessor(object, type, options)
        self.define_aliases(object, type, options)
      end

      def self.define_aliases(object, type, options)
        if type.respond_to?("default_#{self.accessor.to_s}_aliases")
          type.send("default_#{self.accessor.to_s}_aliases", options[:method_name]).each do |alias_method_name|
            object.send(:alias_method, alias_method_name, options[:method_name])
          end
        end        
      end
    end
  end
end