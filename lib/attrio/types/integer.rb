# encoding: utf-8

module Attrio  
  module Types
    class Integer < Base        
      def self.typecast(value, options = {})
        value.to_i
      end
    end
  end
end