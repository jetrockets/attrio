# encoding: utf-8

module Attrio  
  module Types
    class Symbol < Base        
      def self.typecast(value, options = {})
        value.underscore.to_sym
      end
    end
  end
end