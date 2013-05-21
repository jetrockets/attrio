# encoding: utf-8

class Array # :nodoc:
  def extract_options!
    if last.is_a?(Hash) && last.extractable_options?
      pop
    else
      {}
    end
  end unless method_defined?(:extract_options!)

  class << self
    def wrap(object)
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