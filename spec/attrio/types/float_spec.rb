require 'spec_helper'

describe Attrio::Types::Float do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :float_attribute, Float
      end
    end
  end

  let(:object){ model.new }

  context 'assignment' do
    it "should cast float number" do      
      object.float_attribute = 10.0
      object.float_attribute.should == 10.0
    end

    it 'should cast object which has method to_f' do      
      object.float_attribute = "10 test"
      object.float_attribute.should == 10.0
    end
  end
end