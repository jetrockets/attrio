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

    context 'not typecasted assignment' do    
      it 'should cast "true"' do        
        object.boolean_attribute = 'true'
        object.boolean_attribute?.should be_true
      end

      it 'should cast "1"' do        
        object.boolean_attribute = '1'
        object.boolean_attribute?.should be_true
      end

      it 'should cast 1' do      
        object.boolean_attribute = 1
        object.boolean_attribute?.should be_true
      end

      it 'should cast "yes"' do        
        object.boolean_attribute = 'yes'
        object.boolean_attribute?.should be_true
      end

      it 'should cast "false"' do        
        object.boolean_attribute = 'false'
        object.boolean_attribute?.should be_false
      end

      it 'should cast "0"' do        
        object.boolean_attribute = '0'
        object.boolean_attribute?.should be_false
      end

      it 'should cast 0' do        
        object.boolean_attribute = 0
        object.boolean_attribute?.should be_false
      end

      it 'should cast "no"' do      
        object.boolean_attribute = 'no'
        object.boolean_attribute?.should be_false
      end
    end

    context 'typecasted assignment' do
      it 'should assign <TrueClass> and do not typecast' do          
        object.boolean_attribute = true
        object.boolean_attribute?.should be_true
      end

      it 'should assign <FalseClass> and do not typecast' do        
        object.boolean_attribute = false
        object.boolean_attribute?.should be_false
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
      object.boolean_attribute?.should be_true
    end

    it 'should cast anything else as FalseClass' do        
      object.boolean_attribute = 'yes'
      object.boolean_attribute?.should be_false

      object.boolean_attribute = 1
      object.boolean_attribute?.should be_false

      object.boolean_attribute = 0
      object.boolean_attribute?.should be_false
    end
  end  
end