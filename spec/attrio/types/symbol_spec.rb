require 'spec_helper'

describe Attrio::Types::Symbol do
  context 'standard casting conventions' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :symbol_attribute, Symbol
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast <String>' do
        object.symbol_attribute = "symbol"
        object.symbol_attribute.should == :symbol
      end

      it 'should not cast object which has not method to_sym' do
        lambda {
          object.symbol_attribute = []
        }.should_not raise_exception
        object.symbol_attribute.should be_nil
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <Symbol>' do
        symbol = :symbol

        object.symbol_attribute = symbol
        object.symbol_attribute.should == symbol
        object.symbol_attribute.should be_equal(symbol)
      end
    end
  end
end