require 'spec_helper'

describe Attrio::DefaultValue::Symbol do
  subject { described_class.new(object, attribute, default_value) }

  let(:model) do
    Class.new do
      include Attrio

      define_attributes do 
        attr :attribute, Date, :default => :today
        attr :attribute_with_non_existing_method, Symbol, :default => :non_existing_method
      end

      def today
        Date.today
      end
    end
  end

  let(:object){ model.new }

  let(:attribute){ double('attribute')}
  let(:default_value){ double('default_value')}

  it "should set attribute value to appropriate type" do
    expect(object.attribute).to be_instance_of(Date)  
  end

  it "should have value that is returned by method in class" do
    expect(object.attribute).to eq(Date.today)
  end
end