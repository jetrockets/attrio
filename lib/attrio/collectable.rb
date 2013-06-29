# encoding: utf-8

module Attrio
  module Collectable

    def add_element_name
      @add_element_name ||= self.accessor_name_from_options(:add_element) || "add_#{self.name}"
    end

    def add_element_visibility
      @add_element_visibility ||= self.accessor_visibility_from_options(:add_element) || :public
    end

    def find_element_name
      @add_element_name ||= self.accessor_name_from_options(:find_element) || "find_#{self.name}"
    end

    def find_element_visibility
      @add_element_visibility ||= self.accessor_visibility_from_options(:find_element) || :public
    end
  end
end