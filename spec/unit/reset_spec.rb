require 'spec_helper'

describe Attrio::Reset do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :first, String
        attr :second, String, :default => 'default'
        collection :third, String, :initial_values => ['foo','bar']
        collection :fourth, String, unique: true
      end
    end
  end


  let(:object) do
    obj = model.new
    obj.first = 'first'
    obj.second = 'second'
    obj.add_third 'baz'
    obj
  end

  it 'should respond_to reset_attributes' do
    object.respond_to?(:reset_attributes).should be_true    
  end

  it 'should reset attributes without :default option to nil' do
    object.reset_attributes
    object.first.should be_nil
  end

  it 'should reset attributes with :default option to default value' do
    object.reset_attributes
    object.second.should == 'default'
  end

  it 'should respond_to reset_collections' do
    object.respond_to?(:reset_collections).should be_true
  end

  it 'should reset collections without :default option to nil', focus: true do
    object.inspect
    object.reset_collections
    object.fourth.should be_empty
  end

  it 'should reset collections with :default option to default value' do
    object.third.should == ['foo','bar','baz']
    object.reset_collections
    object.third.should == ['foo','bar']
  end
end