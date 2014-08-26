require 'spec_helper'

describe Attrio do
  let(:model) do
    attributes_name = self.respond_to?(:attributes_name) ? self.attributes_name : 'attributes'

    Class.new do
      include Attrio

      define_attributes :as => attributes_name do
        attr :name, String
        attr :age, Integer
        attr :created_at, DateTime, :default => proc{ Time.now }
      end
    end
  end

  context 'Attrio included with default parameters' do
    subject { model }

    it { is_expected.to respond_to(:define_attributes) }
    it { is_expected.to respond_to(:attributes) }

    context 'instance' do
      subject { model.new }

      it { is_expected.to be }
      it { is_expected.to respond_to(:reset_attributes) }
      it { is_expected.to respond_to(:attributes) }

      context '#attributes' do
        it 'should be a kind of Hash' do
          expect(subject.attributes).to be_a_kind_of Hash
        end

        it 'should be present' do
          expect(subject.attributes).to be_present
        end

        it 'should return a full set of attributes' do
          expect(subject.attributes.keys).to match_array([:name, :age, :created_at])
        end

        it 'should return a filtered set of attributes' do
          expect(subject.attributes(:name).keys).to match_array([:name])
          expect(subject.attributes([:name]).keys).to match_array([:name])
        end

        it 'should return a blank set of attributes for not existing filter' do
          expect(subject.attributes([:not_existing_attribute]).keys).to match_array([])
        end
      end
    end
  end

  context 'Attrio included with :as parameter' do
    let(:attributes_name) do
      'api_attributes'
    end

    subject { model }

    it { is_expected.to respond_to(:define_attributes) }
    it { is_expected.to respond_to(:api_attributes) }

    context 'instance' do
      subject { model.new }

      it { is_expected.to be }
      it { is_expected.to respond_to(:reset_api_attributes) }
      it { is_expected.to respond_to(:api_attributes) }

      its(:api_attributes){ should be_present }
    end
  end
end