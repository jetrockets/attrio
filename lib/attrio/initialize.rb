# encoding: utf-8

module Attrio
  module Initialize
    def new(*args, &block)
      obj = self.allocate

      obj.class.attrio.each do |group, options|
        obj.instance_variable_set("@#{group}", {})
        obj.class.send("#{group}").each do |name, attribute|
          obj.send("#{group}")[name] = attribute.dup
          obj.send("#{group}")[name].instance_variable_set(:@object, obj)
          obj.send("#{group}")[name].reset!
        end
      end

      obj.send :initialize, *args, &block
      obj
    end
  end
end