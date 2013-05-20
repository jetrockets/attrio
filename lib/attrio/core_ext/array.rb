# encoding: utf-8

class Array # :nodoc:
  def extract_options!
    if last.is_a?(Hash) && last.extractable_options?
      pop
    else
      {}
    end
  end unless method_defined?(:extract_options!)
end