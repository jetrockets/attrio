require 'spec_helper'

describe Attrio::Types::Date do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :time_attribute, Time
      end
    end
  end

  let(:object){ model.new }
  
  context 'assignment' do
    it "should cast time" do
      object.time_attribute.should be_nil

      time = Time.now
      object.time_attribute = time
      object.time_attribute.should == time
    end

    it 'should cast string time' do
      object.time_attribute.should be_nil
      object.time_attribute = "2013-05-21T19:01:48"
      object.time_attribute.should == Time.new(2013, 05, 21, 19, 01, 48)
    end
  end

  # :format => '%H-%M-%S:%d:%m:%Y'
  # 
  # it 'should parse string date' do
  #   object.time_attribute.should be_nil
  #   object.time_attribute = "19-01-48:21:05:2013"
  #   object.time_attribute.should == Time.new(2013, 05, 21, 19, 01, 48)
  # end
end