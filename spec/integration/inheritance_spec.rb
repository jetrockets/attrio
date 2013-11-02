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

      it "should include not overriden attributes" do
        should include(Parent.attributes.reject { |k| k == :name })
      end

      it "should include overriden attributes" do
        should include(:name)
      end

      it "should include overriden attributes with corect options" do
        subject[:name].type.should == Attrio::Types::Symbol
      end
    end
  end
end