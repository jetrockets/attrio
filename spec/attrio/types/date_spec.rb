require 'spec_helper'

describe Attrio::Types::Date do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :date_attribute, Date
      end
    end
  end

  let(:object){ model.new }
  
  context 'assignment' do
    it "should cast date" do
      object.date_attribute.should be_nil
      object.date_attribute = Date.today
      object.date_attribute.should == Date.today
    end

    it 'should cast string date' do
      object.date_attribute.should be_nil
      object.date_attribute = "2013-05-21"
      object.date_attribute.should == Date.parse("2013-05-21")
    end
  end

  # :format => '%d:%m:%Y'

  # it 'should parse string date' do
  #   object.date_attribute.should be_nil
  #   object.date_attribute = "21:05:2013"
  #   object.date_attribute.should == Date.parse("2013-05-21")
  # end
end