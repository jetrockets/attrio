module Attrio
  module Utility
    extend self

    def to_a(object)
      if object.nil?
        []
      elsif object.respond_to?(:to_ary)
        object.to_ary || [object]
      else
        [object]
      end
    end unless method_defined?(:wrap)
  end
end
