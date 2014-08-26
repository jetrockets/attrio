require 'spec_helper'

describe Attrio::Types::Base do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :type_as_constant, Integer
        attr :type_in_options_as_constant, :type => Integer
        attr :type_as_string, 'integer'
        attr :type_in_options_as_string, :type => 'integer'
        attr :type_as_symbol, :integer
        attr :type_in_options_as_symbol, :type => :integer
      end
    end
  end

  it 'should set appropriate type by all available options ' do
    model.attributes.values.each { |attribute| expect(attribute.type).to be(Attrio::Types::Integer) }
  end
end