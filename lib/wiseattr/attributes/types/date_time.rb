# encoding: utf-8

module Wiseattr
  module Attributes
    module Types
      class DateTime < Base        
        def self.typecast(value, options = {})
          options[:format].present? ? ::DateTime.strftime(value, options[:format]) : ::DateTime.parse(value)
        end
      end
    end
  end
end