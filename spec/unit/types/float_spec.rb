require 'spec_helper'

describe Attrio::Types::Float do
  context 'standard casting conventions' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :float_attribute, Float
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast object which has method to_f' do
        object.float_attribute = "10 test"
        expect(object.float_attribute).to eq(10.0)
      end

      it 'should not cast object which has not method to_f' do
        expect {
          object.float_attribute = []
        }.not_to raise_exception
        expect(object.float_attribute).to be_nil
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <Float>' do
        object.float_attribute = 10.0
        expect(object.float_attribute).to eq(10.0)
      end
    end
  end
end