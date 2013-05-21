require 'spec_helper'

describe Attrio::Types::Symbol do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :symbol_attribute, Symbol
      end
    end
  end

  let(:object){ model.new }

  context 'assignment' do
    it "should cast symbol" do
      object.symbol_attribute.should be_nil
      object.symbol_attribute = :symbol
      object.symbol_attribute.should == :symbol
    end

    it 'should cast object which has method to_sym' do
      object.symbol_attribute.should be_nil
      object.symbol_attribute = "symbol"
      object.symbol_attribute.should == :symbol
    end
  end
end