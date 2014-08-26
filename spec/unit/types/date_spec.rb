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
        expect(object.date_attribute).to be_instance_of(Date)
        expect(object.date_attribute).to eq(today)
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <Date>' do
        today = Date.today

        object.date_attribute = today
        expect(object.date_attribute).to be_instance_of(Date)
        expect(object.date_attribute).to be_equal(today)
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
        expect(object.date_attribute).to be_instance_of(Date)
        expect(object.date_attribute).to eq(today)
      end

      it 'should not cast <String> with invalid format' do
        today = Date.today

        expect {
          object.date_attribute = today.strftime('%d-%m-%Y')
        }.not_to raise_exception
        expect(object.date_attribute).to be_nil
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <Date>' do
        today = Date.today

        object.date_attribute = today
        expect(object.date_attribute).to be_instance_of(Date)
        expect(object.date_attribute).to be_equal(today)
      end
    end
  end
end