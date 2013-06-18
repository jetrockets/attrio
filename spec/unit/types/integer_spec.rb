require 'spec_helper'

describe Attrio::Types::Integer do
  context 'standard casting conventions' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :integer_attribute, Integer
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast an object which has method to_i' do
        object.integer_attribute = "10 test"
        object.integer_attribute.should == 10
      end

      it 'should not cast an object which has not method to_i' do
        lambda {
          object.integer_attribute = []
        }.should_not raise_exception
        object.integer_attribute.should be_nil
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <Integer>' do
        object.integer_attribute = 10
        object.integer_attribute.should == 10
      end
    end
  end

  context ':base option passed' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :integer_attribute, Integer, :base => 16
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast <String> considering :base option' do
        object.integer_attribute = "A"
        object.integer_attribute.should == 10
      end

      it 'should cast an object which has method to_i' do
        object.integer_attribute = 10.0
        object.integer_attribute.should == 10
      end

      it 'should not cast an object which has not method to_i' do
        lambda {
          object.integer_attribute = []
        }.should_not raise_exception
        object.integer_attribute.should be_nil
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <Integer>' do
        object.integer_attribute = 10
        object.integer_attribute.should == 10
      end
    end
  end
end