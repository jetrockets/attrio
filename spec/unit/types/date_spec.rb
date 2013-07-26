require 'spec_helper'

describe Attrio::Types::Date do
  context 'standard casting conventions' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :date_attribute, Date
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast <String>' do
        today = Date.today

        object.date_attribute = today.to_s
        object.date_attribute.should be_instance_of(Date)
        object.date_attribute.should == today
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <Date>' do
        today = Date.today

        object.date_attribute = today
        object.date_attribute.should be_instance_of(Date)
        object.date_attribute.should be_equal(today)
      end
    end
  end

  context ':format option passed' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :date_attribute, Date, :format => '%m/%d/%y'
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast <String> of appropriate format' do
        today = Date.today

        object.date_attribute = today.strftime('%m/%d/%y')
        object.date_attribute.should be_instance_of(Date)
        object.date_attribute.should == today
      end

      it 'should not cast <String> with invalid format' do
        today = Date.today

        lambda {
          object.date_attribute = today.strftime('%d-%m-%Y')
        }.should_not raise_exception
        object.date_attribute.should be_nil
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <Date>' do
        today = Date.today

        object.date_attribute = today
        object.date_attribute.should be_instance_of(Date)
        object.date_attribute.should be_equal(today)
      end
    end
  end
end