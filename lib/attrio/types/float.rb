# encoding: utf-8

module Attrio  
  module Types
    class Float < Base        
      def self.typecast(value, options = {})
        value.to_f
      end
    end
  end
end