# encoding: utf-8

class String # :nodoc:
  def underscore
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end unless method_defined?(:underscore)

  def camelize
    self.split(/[^a-z0-9]/i).map{|w| w.capitalize}.join
  end unless method_defined?(:camelize)

  def demodulize
    if i = self.rindex('::')
      self[(i+2)..-1]
    else
      self
    end
  end unless method_defined?(:demodulize)
end