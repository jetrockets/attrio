require 'spec_helper'

describe Attrio::Types::Boolean do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :boolean_attribute, Boolean
      end

      def reset!
        self.attributes.values { |attribute| self.instance_variable_set(attribute.instance_variable_name, nil) }
      end
    end
  end

  let(:object){ model.new }
  
  context 'not typecasted assignment' do
    before(:each) do
      object.reset!
    end

    context 'standard boolean casting conventions' do

      it 'should cast "true"' do
        object.boolean_attribute = 'true'
        object.boolean_attribute?.should be_true      
      end

      it 'should cast "1"' do
        object.boolean_attribute = '1'
        object.boolean_attribute?.should be_true      
      end
    end
  end

end