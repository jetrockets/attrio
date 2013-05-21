require 'spec_helper'

describe Attrio::Types::Boolean do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :boolean_attribute, Boolean
      end
    end
  end

  let(:object){ model.new }
  
  context 'not typecasted assignment' do
    context 'standard boolean casting conventions' do
      it 'should cast "true"' do  
        object.boolean_attribute?.should be_nil
        object.boolean_attribute = 'true'
        object.boolean_attribute?.should be_true
      end

      it 'should cast "1"' do
        object.boolean_attribute?.should be_nil
        object.boolean_attribute = '1'
        object.boolean_attribute?.should be_true
      end

      it 'should cast 1' do
        object.boolean_attribute?.should be_nil
        object.boolean_attribute = 1
        object.boolean_attribute?.should be_true
      end

      it 'should cast "yes"' do
        object.boolean_attribute?.should be_nil
        object.boolean_attribute = 'yes'
        object.boolean_attribute?.should be_true
      end
    end

    context 'standard boolean casting conventions' do

    end
  end
end