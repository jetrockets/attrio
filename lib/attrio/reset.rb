# encoding: utf-8

module Attrio
  module Reset
    def self.included(base)
      base.send(:extend, Attrio::Reset::ClassMethods)
    end

    module ClassMethods
      def define_attrio_reset(as)
        define_method "reset_#{as.to_s}" do |attributes = []|
          self.send(as.to_s, attributes).values.each{ |attribute| attribute.reset! }
        end
      end
    end
  end
end