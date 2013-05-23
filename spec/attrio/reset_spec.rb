require 'spec_helper'

describe Attrio::Reset do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :first, String
        attr :second, String, :default => 'default'
      end
    end
  end

  let(:object) do 
    obj = model.new
    obj.first = 'first'
    obj.second = 'second'
    obj
  end

  it 'should respond_to reset_attributes' do
    object.respond_to?(:reset_attributes).should be_true
    object.respond_to?(:reset_attributes!).should be_true
  end

  it 'should reset attributes without :default option to nil' do
    object.reset_attributes
    object.first.should be_nil
  end

  it 'should reset attributes with :default option to default value' do
    object.reset_attributes
    object.second.should == 'default'
  end
end