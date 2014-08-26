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
        is_expected.to eq(Parent.attributes)
      end
    end

    context "with new attributes" do
      subject { ChildWithNewAttributes.attributes }

      it "should include parent's attributes" do
        is_expected.to include(Parent.attributes)
      end
    end

    context "with overriden attributes" do
      subject { ChildWithOverridenAttributes.attributes }

      it "should include not overriden attributes" do
        is_expected.to include(Parent.attributes.reject { |k| k == :name })
      end

      it "should include overriden attributes" do
        is_expected.to include(:name)
      end

      it "should include overriden attributes with corect options" do
        expect(subject[:name].type).to eq(Attrio::Types::Symbol)
      end
    end
  end
end