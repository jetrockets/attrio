require 'spec_helper'

describe Attrio::Types::Time do
  context 'standard casting conventions' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :time_attribute, Time
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast <String>' do
        now = Time.at(Time.now.to_i)

        object.time_attribute = now.to_s
        expect(object.time_attribute).to be_instance_of(Time)
        expect(object.time_attribute).to eq(now)
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <Time>' do
        now = Time.now

        object.time_attribute = now
        expect(object.time_attribute).to be_instance_of(Time)
        expect(object.time_attribute).to be_equal(now)
      end
    end
  end

  context ':format option passed' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :time_attribute, Time, :format => '%m/%d/%y-%H:%M:%S'
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast <String> of appropriate format' do
        now = Time.at(Time.now.to_i)

        object.time_attribute = now.strftime('%m/%d/%y-%H:%M:%S')
        expect(object.time_attribute).to be_instance_of(Time)
        expect(object.time_attribute).to eq(now)
      end

      it 'should not cast <String> with invalid format' do
        now = Time.now

        expect {
          object.time_attribute = now.strftime('%H:%M:%S-%m/%d/%y')
        }.not_to raise_exception
        expect(object.time_attribute).to be_nil
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <Time>' do
        now = Time.now

        object.time_attribute = now
        expect(object.time_attribute).to be_instance_of(Time)
        expect(object.time_attribute).to be_equal(now)
      end
    end
  end
end