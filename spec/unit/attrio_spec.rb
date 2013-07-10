require 'spec_helper'

describe Attrio do  
  let(:model) do
    attributes_name = self.respond_to?(:attributes_name) ? self.attributes_name : 'attributes'
    collections_name = self.respond_to?(:collections_name) ? self.collections_name : 'collections'

    Class.new do 
      include Attrio

      define_attributes :as => attributes_name, :c_as => collections_name do
        attr :name, String
        attr :age, Integer
        attr :created_at, DateTime, :default => proc{ Time.now }
        collection :favorites, String, unique: true
        collection :dates, Date
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

      context '#collections' do
        it 'should be a kind of Hash' do
          subject.collections.should be_a_kind_of Hash
        end

        it 'should be present' do
          subject.collections.should be_present
        end

        it 'should return a full set of collections' do
          subject.collections.keys.should match_array([:favorites, :dates])
        end

        it 'should return a filtered set of collections' do
          subject.collections(:dates).keys.should match_array([:dates])
          subject.collections([:favorites]).keys.should match_array([:favorites])
        end

        it 'should return a blank set of collections for not existing filter' do
          subject.collections([:not_existing_attribute]).keys.should match_array([])
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

  context 'Attrio included with :c_as parameter' do
    let(:collections_name) do
      'api_collections'
    end

    subject { model }

    it { should respond_to(:api_collections) }

    context 'instance' do
      subject { model.new }

      it { should be }
      it { should respond_to(:reset_api_collections) }
      it { should respond_to(:initialize_api_collections) }
      it { should respond_to(:empty_api_collections) }
      it { should respond_to(:api_collections) }

      its(:api_collections){ should be_present }
    end
  end

end