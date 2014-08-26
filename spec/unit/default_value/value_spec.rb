require 'spec_helper'

describe Attrio::DefaultValue do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :attribute_without_default_value, Date
        attr :attribute_with_default_value, Integer, :default => 1
        # attr :attribute_with_callable_default_value, DateTime, :default => lambda{ DateTime.now }
        # attr :attribute_with_clonable_default_value, Date, :default => Date.today
        # attr :attribute_with_symbol_default_value, Date, :default => :today
        # attr :attribute_with_non_existing_method_default_value, Symbol, :default => :non_existing_method
      end

      def today
        Date.today
      end
    end
  end

  let(:object){ model.new }
  
  context 'default value is not set' do
    it "should set attribute to nil" do
      expect(object.attribute_without_default_value).to be_nil
    end
  end

  context 'default value is set as a not clonable object' do
    it "should set attribute value to appropriate type" do
      expect(object.attribute_with_default_value).to be_instance_of(Fixnum)
    end

    it "should be equal to attribute value" do
      expect(object.attribute_with_default_value).to be_equal(1)
    end
  end

  # context 'default value is set as a callable' do
  #   it "should set attribute value to appropriate type" do    
  #     object.attribute_with_callable_default_value.should be_instance_of(DateTime)  
  #   end

  #   it "should be evaluate attribute value every time" do      
  #     object.attribute_with_callable_default_value.should < another_object.attribute_with_callable_default_value
  #   end
  # end

  # context 'default value is set as a clonable object' do
  #   it "should set attribute value to appropriate type" do
  #     object.attribute_with_clonable_default_value.should be_instance_of(Date)  
  #   end

  #   it "should not be equal to clonable object" do
  #     object.attribute_with_clonable_default_value.should_not be_equal(Date.today)
  #   end

  #   it "should have the same value as clonable object" do
  #     object.attribute_with_clonable_default_value.should == Date.today
  #   end
  # end

  # context 'default value is set as a symbol' do
  #   it "should set attribute value to appropriate type" do
  #     object.attribute_with_clonable_default_value.should be_instance_of(Date)  
  #   end

  #   it "should have value that is returned by method in class" do
  #     object.attribute_with_clonable_default_value.should == Date.today
  #   end
  # end
end