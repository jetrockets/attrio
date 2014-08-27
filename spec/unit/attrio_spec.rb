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

    it { should respond_to(:define_attributes) }
    it { should respond_to(:attributes) }

    context 'instance' do
      subject { model.new }

      it { should be }
      it { should respond_to(:reset_attributes) }
      it { should respond_to(:attributes) }

      context '#attributes' do
        it 'should be a kind of Hash' do
          subject.attributes.should be_a_kind_of Hash
        end

        it 'should be present' do
          subject.attributes.should be_present
        end

        it 'should return a full set of attributes' do
          subject.attributes.keys.should match_array([:name, :age, :created_at])
        end

        it 'should return a filtered set of attributes' do
          subject.attributes(:name).keys.should match_array([:name])
          subject.attributes([:name]).keys.should match_array([:name])
        end

        it 'should return a blank set of attributes for not existing filter' do
          subject.attributes([:not_existing_attribute]).keys.should match_array([])
        end
      end
    end
  end

  context 'Attrio included with :as parameter' do
    let(:attributes_name) do
      'api_attributes'
    end

    subject { model }

    it { should respond_to(:define_attributes) }
    it { should respond_to(:api_attributes) }

    context 'instance' do
      subject { model.new }

      it { should be }
      it { should respond_to(:reset_api_attributes) }
      it { should respond_to(:api_attributes) }

      its(:api_attributes){ should be_present }
    end
  end

  describe 'includeing MassAssignment' do
    module MassAssignment
      def initialize(attributes = {})
        self.attributes = attributes
      end

      def attributes=(attributes = {})
        attributes.each do |attr,value|
          self.send("#{attr}=", value) if self.respond_to?("#{attr}=")
        end
      end
    end

    let(:model) do
      Class.new do
        include Attrio
        include MassAssignment

        define_attributes do
          attr :name, String
          attr :age, Integer
          attr :activated, Boolean
        end
      end
    end

    context "initialize with attributes" do
      subject do
        model.new(
          name: "name",
          age: 0,
          activated: false,
        )
      end

      it { expect(subject.name).to eq "name" }
      it { expect(subject.age).to eq 0 }
      it { expect(subject.activated).to eq false }
    end
  end
end
