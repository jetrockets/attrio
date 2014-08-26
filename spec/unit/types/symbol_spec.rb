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
        object.symbol_attribute = "CamelCase"
        expect(object.symbol_attribute).to eq(:CamelCase)
      end

      it 'should not cast an object which has not method to_sym' do
        expect {
          object.symbol_attribute = []
        }.not_to raise_exception
        expect(object.symbol_attribute).to be_nil
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <Symbol>' do
        symbol = :symbol

        object.symbol_attribute = symbol
        expect(object.symbol_attribute).to eq(symbol)
        expect(object.symbol_attribute).to be_equal(symbol)
      end
    end
  end

  context ':underscore option passed' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :symbol_attribute, Symbol, :underscore => true
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast <String>' do
        object.symbol_attribute = "CamelCase"
        expect(object.symbol_attribute).to eq(:camel_case)
      end

      it 'should not cast an object which has not method to_sym' do
        expect {
          object.symbol_attribute = []
        }.not_to raise_exception
        expect(object.symbol_attribute).to be_nil
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <Symbol>' do
        symbol = :symbol

        object.symbol_attribute = symbol
        expect(object.symbol_attribute).to eq(symbol)
        expect(object.symbol_attribute).to be_equal(symbol)
      end
    end
  end
end