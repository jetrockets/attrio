require 'spec_helper'

describe Attrio::DefaultValue::Clonable do
  subject { described_class.new(attribute, default_value) }

  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :attribute, Date, :default => Date.today
      end
    end
  end

  let(:object){ model.new }

  let(:attribute){ double('attribute')}
  let(:default_value){ double('default_value')}
  let(:instance)  { double('instance') }
  let(:clone)     { double('clone') }

  before { allow(default_value).to receive_messages(:clone => clone) }

  it 'should clone the value' do
    expect(default_value).to receive(:clone).with(no_args)
    subject.call(instance)
  end

  it 'should be an instance of a cloned value' do
    expect(subject.call(instance)).to be(clone)
  end

  it "should set attribute value to appropriate type" do
    expect(object.attribute).to be_instance_of(Date)
  end

  it "should not be equal to clonable object" do
    expect(object.attribute).not_to be_equal(Date.today)
  end

  it "should have the same value as clonable object" do
    expect(object.attribute).to eq(Date.today)
  end
end