require 'spec_helper'

describe Attrio::Types::DateTime do
  context 'standard casting conventions' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :datetime_attribute, DateTime
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast <String>' do
        now = Time.at(Time.now.to_i).to_datetime

        object.datetime_attribute = now.to_s
        object.datetime_attribute.should be_instance_of(DateTime)
        object.datetime_attribute.should == now
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <DateTime>' do
        now = DateTime.now

        object.datetime_attribute = now
        object.datetime_attribute.should be_instance_of(DateTime)
        object.datetime_attribute.should be_equal(now)
      end
    end
  end

  context ':format option passed' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :datetime_attribute, DateTime, :format => '%m/%d/%y-%H:%M:%S-%z'
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast <String> of appropriate format' do
        now = Time.at(Time.now.to_i).to_datetime

        object.datetime_attribute = now.strftime('%m/%d/%y-%H:%M:%S-%z')
        object.datetime_attribute.should be_instance_of(DateTime)
        object.datetime_attribute.should == now
      end

      it 'should not cast <String> with invalid format' do
        now = DateTime.now

        lambda {
          object.datetime_attribute = now.strftime('%H:%M:%S-%m/%d/%y')
        }.should_not raise_exception
        object.datetime_attribute.should be_nil
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <DateTime>' do
        now = DateTime.now

        object.datetime_attribute = now
        object.datetime_attribute.should be_instance_of(DateTime)
        object.datetime_attribute.should be_equal(now)
      end
    end
  end
end