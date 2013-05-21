require 'spec_helper'

describe Attrio::Types::Date do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :date_time_attribute, DateTime
      end
    end
  end

  let(:object){ model.new }

  context 'assignment' do
    it "should cast DateTime" do
      object.date_time_attribute.should be_nil

      date_time = DateTime.now
      object.date_time_attribute = date_time
      object.date_time_attribute.should == date_time
    end

    it 'should cast string DateTime' do
      object.date_time_attribute.should be_nil
      object.date_time_attribute = "2013-05-21T19:01:48"
      object.date_time_attribute.should == DateTime.new(2013, 05, 21, 19, 01, 48)
    end
  end

  # :format => '%H-%M-%S:%d:%m:%Y'

  # it 'should parse string date' do
  #   object.date_time_attribute.should be_nil
  #   object.date_time_attribute = "19-01-48:21:05:2013"
  #   object.date_time_attribute.should == DateTime.new(2013, 05, 21, 19, 01, 48)
  # end
end