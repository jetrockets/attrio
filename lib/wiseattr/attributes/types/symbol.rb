# encoding: utf-8

module Wiseattr
  module Attributes
    module Types
      class Symbol < Base        
        def self.typecast(value, options = {})
          value.underscore.to_sym
        end
      end
    end
  end
end