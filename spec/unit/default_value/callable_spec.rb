require 'spec_helper'

describe Attrio::DefaultValue::Callable do
  subject { described_class.new(attribute, default_value) }

  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :attribute, DateTime, :default => proc{ DateTime.now }
      end
    end
  end

  let(:object){ model.new }

  let(:attribute){ double('attribute')}
  let(:default_value){ double('default_value')}
  let(:response)  { double('response') }

  before { allow(default_value).to receive_messages(:call => response) }
  it 'should call the value with the object and attribute' do
    expect(default_value).to receive(:call).with(object, attribute).and_return(response)
    subject.call(object)
  end

  it "should set attribute value to appropriate type" do
    expect(object.attribute).to be_instance_of(DateTime)
  end

  it "should be evaluate attribute value every time" do
    another_object = model.new

    expect(object.attribute).not_to be_equal(another_object.attribute)
  end
end