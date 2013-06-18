require 'spec_helper'

describe 'Attributes inheritance' do  
  before(:all) do
    class Parent
      include Attrio

      define_attributes do
        attr :email, String
        attr :name, String    
        attr :created_at, DateTime, :default => proc{ Time.now }
      end
    end

    class ChildWithoutAttributes < Parent      
    end

    class ChildWithNewAttributes < Parent
      define_attributes do
        attr :age, Integer
      end
    end

    class ChildWithOverridenAttributes < Parent
      define_attributes do
        attr :name, Symbol
      end
    end
  end

  context 'Classes should inherit attributes' do
    subject { ChildWithoutAttributes.attributes }

    it do
      should match_hash(Parent.attributes)
    end
  end
end