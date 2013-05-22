require 'spec_helper'

describe Attrio::Types::Integer do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :integer_attribute, Integer
      end
    end
  end

  let(:object){ model.new }
  
  context 'assignment' do
    it "should cast integer number" do      
      object.integer_attribute = 100
      object.integer_attribute.should == 100
    end

    it 'should cast object which has method to_i' do      
      object.integer_attribute = "100 test"
      object.integer_attribute.should == 100
    end
  end
end