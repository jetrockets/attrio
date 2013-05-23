# encoding: utf-8

class Object
  def blank?
    !self     
  end unless method_defined? :blank?

  def present?
    !blank?
  end unless method_defined? :present?

  def try(*a, &b)
    if a.empty? && block_given?
      yield self
    else
      __send__(*a, &b)
    end
  end unless method_defined? :try?
end