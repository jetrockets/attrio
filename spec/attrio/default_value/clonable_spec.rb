require 'spec_helper'

describe Attrio::DefaultValue::Clonable do
  subject { described_class.new(object, attribute, default_value) }

  let(:model) do
    Class.new do
      include Attrio

      define_attributes do        
        attr :attribute, Date, :default => Date.today        
      end      
    end
  end

  let(:object){ model.new }

  let(:attribute){ mock('attribute')}
  let(:default_value){ mock('default_value')}
  let(:instance)  { mock('instance') }
  let(:clone)     { mock('clone') }

  before { default_value.stub(:clone => clone) }

  it 'should clone the value' do
    default_value.should_receive(:clone).with(no_args)
    subject.call(instance)
  end

  it 'should be an instance of a cloned value' do
    subject.call(instance).should be(clone)
  end

  it "should set attribute value to appropriate type" do
    object.attribute.should be_instance_of(Date)  
  end

  it "should not be equal to clonable object" do
    object.attribute.should_not be_equal(Date.today)
  end

  it "should have the same value as clonable object" do
    object.attribute.should == Date.today
  end  
end