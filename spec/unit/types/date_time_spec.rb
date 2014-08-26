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
        now = Time.at(Time.now.to_i).send :to_datetime

        object.datetime_attribute = now.to_s
        expect(object.datetime_attribute).to be_instance_of(DateTime)
        expect(object.datetime_attribute).to eq(now)
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <DateTime>' do
        now = DateTime.now

        object.datetime_attribute = now
        expect(object.datetime_attribute).to be_instance_of(DateTime)
        expect(object.datetime_attribute).to be_equal(now)
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
        now = Time.at(Time.now.to_i).send :to_datetime

        object.datetime_attribute = now.strftime('%m/%d/%y-%H:%M:%S-%z')
        expect(object.datetime_attribute).to be_instance_of(DateTime)
        expect(object.datetime_attribute).to eq(now)
      end

      it 'should not cast <String> with invalid format' do
        now = DateTime.now

        expect {
          object.datetime_attribute = now.strftime('%H:%M:%S-%m/%d/%y')
        }.not_to raise_exception
        expect(object.datetime_attribute).to be_nil
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <DateTime>' do
        now = DateTime.now

        object.datetime_attribute = now
        expect(object.datetime_attribute).to be_instance_of(DateTime)
        expect(object.datetime_attribute).to be_equal(now)
      end
    end
  end
end