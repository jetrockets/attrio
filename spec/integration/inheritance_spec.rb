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
    context "without attributes" do
      subject { ChildWithoutAttributes.attributes }

      it "should equal to parent's attributes" do
        should == Parent.attributes
      end
    end

    context "with new attributes" do
      subject { ChildWithNewAttributes.attributes }

      it "should include parent's attributes" do
        should include(Parent.attributes)
      end
    end

    context "with overriden attributes" do
      subject { ChildWithOverridenAttributes.attributes }

      pending "should include not overriden attributes"
    end
  end
end