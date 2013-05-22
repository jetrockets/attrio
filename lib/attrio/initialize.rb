# encoding: utf-8

module Attrio
  module Initialize
    def self.included(base)
      base.send(:extend, Attrio::Initialize::ClassMethods)
    end

    module ClassMethods
      def define_attrio_new(as)
        # define_singleton_method(:new) do |*args, &block|
        #   obj = self.allocate
        #   obj.send "reset_#{as}!"
        #   obj.send :initialize, *args, &block          
        #   obj
        # end

        class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          def self.new(*args, &block)
            obj = self.allocate
            obj.send "reset_#{as}!"
            obj.send :initialize, *args, &block          
            obj
          end
        EOS
      end
    end
  end
end