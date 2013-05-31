# encoding: utf-8

class Object
  def blank?
    !self     
  end unless method_defined? :blank?

  def present?
    !blank?
  end unless method_defined? :present?
end