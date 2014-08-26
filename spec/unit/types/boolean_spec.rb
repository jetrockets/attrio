require 'spec_helper'

describe Attrio::Types::Boolean do
  context 'standard casting conventions' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :boolean_attribute, Boolean
        end
      end
    end

    let(:object){ model.new }

    context 'with not typecasted assignment' do
      it 'should cast "true"' do
        object.boolean_attribute = 'true'
        expect(object.boolean_attribute?).to be_truthy
      end

      it 'should cast "1"' do
        object.boolean_attribute = '1'
        expect(object.boolean_attribute?).to be_truthy
      end

      it 'should cast 1' do
        object.boolean_attribute = 1
        expect(object.boolean_attribute?).to be_truthy
      end

      it 'should cast "yes"' do
        object.boolean_attribute = 'yes'
        expect(object.boolean_attribute?).to be_truthy
      end

      it 'should cast "false"' do
        object.boolean_attribute = 'false'
        expect(object.boolean_attribute?).to be_falsey
      end

      it 'should cast "0"' do
        object.boolean_attribute = '0'
        expect(object.boolean_attribute?).to be_falsey
      end

      it 'should cast 0' do
        object.boolean_attribute = 0
        expect(object.boolean_attribute?).to be_falsey
      end

      it 'should cast "no"' do
        object.boolean_attribute = 'no'
        expect(object.boolean_attribute?).to be_falsey
      end
    end

    context 'with typecasted assignment' do
      it 'should assign <TrueClass> and do not typecast' do
        object.boolean_attribute = true
        expect(object.boolean_attribute?).to be_truthy
      end

      it 'should assign <FalseClass> and do not typecast' do
        object.boolean_attribute = false
        expect(object.boolean_attribute?).to be_falsey
      end
    end
  end

  context 'overriden TrueClass casting with "yeah" value' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :boolean_attribute, Boolean, :true => ['yeah']
        end
      end
    end

    let(:object){ model.new }

    it 'should cast "yeah" as TrueClass' do
      object.boolean_attribute = 'yeah'
      expect(object.boolean_attribute?).to be_truthy
    end

    it 'should cast anything else as FalseClass' do
      object.boolean_attribute = 'yes'
      expect(object.boolean_attribute?).to be_falsey

      object.boolean_attribute = 1
      expect(object.boolean_attribute?).to be_falsey

      object.boolean_attribute = 0
      expect(object.boolean_attribute?).to be_falsey
    end
  end
end