# encoding: utf-8

module Wiseattr
  module Attributes
    module Types
      class Date < Base        
        def self.typecast(value, options = {})          
          options[:format].present? ? ::Date.strftime(value, options[:format]) : ::Date.parse(value)
        end
      end
    end
  end
end