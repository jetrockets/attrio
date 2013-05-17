# encoding: utf-8

module Wiseattr
  module Attributes
    module Types
      class Time < Base        
        def self.typecast(value, options = {})
          options[:format].present? ? ::Time.strftime(value, options[:format]) : ::Time.parse(value)
        end
      end
    end
  end
end