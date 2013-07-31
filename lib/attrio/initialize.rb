# encoding: utf-8

module Attrio
  module Initialize
    def self.included(base)
      base.send(:extend, Attrio::Initialize::ClassMethods)
    end

    module ClassMethods
      def define_attrio_new(as)
        class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          def self.new(*args, &block)
            obj = self.allocate

            obj.instance_variable_set("@#{as}", {})
            obj.class.send("#{as}").each do |name, attribute|
              obj.send("#{as}")[name] = attribute.dup
              obj.send("#{as}")[name].instance_variable_set(:@object, obj)
              obj.send("#{as}")[name].reset!
            end

            obj.send :initialize, *args, &block

            # obj.send "set_#{as}_defaults"
            obj
          end
        EOS
      end
    end
  end
end