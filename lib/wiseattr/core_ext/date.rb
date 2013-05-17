# encoding: utf-8

class Date
  def inspect
    self.strftime("%a, %d %b %Y")
  end
end