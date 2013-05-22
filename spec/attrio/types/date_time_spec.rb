require 'spec_helper'

describe Attrio::Types::DateTime do
  context 'standard casting conventions' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :date_time_attribute, DateTime
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast <String>' do
        now = DateTime.now

        object.date_time_attribute = now.to_s
        object.date_time_attribute.should be_instance_of(DateTime)
        object.date_time_attribute.should == now
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <DateTime>' do
        now = DateTime.now

        object.date_time_attribute = now
        object.date_time_attribute.should be_instance_of(DateTime)
        object.date_time_attribute.should be_equal(now)
      end
    end
  end

  context ':format option passed' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :date_time_attribute, DateTime, :format => '%m/%d/%y-%H:%M:%S'
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast <String> of appropriate format' do
        now = DateTime.now

        object.date_time_attribute = now.strftime('%m/%d/%y-%H:%M:%S')
        object.date_time_attribute.should be_instance_of(DateTime)
        object.date_time_attribute.should == now
      end

      it 'should not cast <String> with invalid format' do
        now = DateTime.now

        lambda {
          object.date_time_attribute = now.strftime('%m/%d/%y-%H:%M:%S')
        }.should_not raise_exception
        object.date_time_attribute.should be_nil
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <DateTime>' do
        now = DateTime.now

        object.date_time_attribute = now
        object.date_time_attribute.should be_instance_of(DateTime)
        object.date_time_attribute.should be_equal(now)
      end
    end
  end
end