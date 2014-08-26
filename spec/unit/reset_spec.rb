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
    expect(object.respond_to?(:reset_attributes)).to be_truthy
  end

  it 'should reset attributes without :default option to nil' do
    object.reset_attributes
    expect(object.first).to be_nil
  end

  it 'should reset attributes with :default option to default value' do
    object.reset_attributes
    expect(object.second).to eq('default')
  end
end