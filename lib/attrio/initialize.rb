# encoding: utf-8

module Attrio
  module Initialize
    def new(*args, &block)
      obj = self.allocate

      obj.send :initialize, *args, &block

      obj.class.attrio.each do |group, options|
        obj.instance_variable_set("@#{group}", {})
        obj.class.send("#{group}").each do |name, attribute|
          obj.send("#{group}")[name] = attribute.dup
          obj.send("#{group}")[name].instance_variable_set(:@object, obj)
          obj.send("#{group}")[name].reset! if obj.send(name).blank?
        end
      end

      obj
    end
  end
end