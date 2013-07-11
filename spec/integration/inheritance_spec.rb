require 'spec_helper'

describe 'Attributes inheritance' do  
  before(:all) do
    class Parent
      include Attrio

      define_attributes do
        attr :email, String
        attr :name, String    
        attr :created_at, DateTime, :default => proc{ Time.now }
        collection :friends, String
        collection :tags, String
      end
    end

    class ChildWithoutAttributes < Parent      
    end

    class ChildWithNewAttributes < Parent
      define_attributes do
        attr :age, Integer
        collection :favorites, String, :unique => true
      end
    end

    class ChildWithOverridenAttributes < Parent
      define_attributes do
        attr :name, Symbol
        collection :friends, Symbol
      end
    end
  end

  context 'Classes should inherit attributes and collections' do
    context "without attributes" do
      let(:attributes)  { ChildWithoutAttributes.attributes  }
      let(:collections) { ChildWithoutAttributes.collections }

      it "should equal to parent's attributes" do
        attributes.should == Parent.attributes
      end
      it "should equal to parent's collections" do
        collections.should == Parent.collections
      end
    end

    context "with new attributes" do
      let(:attributes)  { ChildWithNewAttributes.attributes  }
      let(:collections) { ChildWithNewAttributes.collections }
      it "should include parent's attributes" do
        attributes.should include(Parent.attributes)
      end
      it "should include parent's collections" do
        collections.should include(Parent.collections)
      end
    end

    context "with overriden attributes" do
      let(:attributes)  { ChildWithOverridenAttributes.attributes  }
      let(:collections) { ChildWithOverridenAttributes.collections }
      it "should include not overriden attributes" do
        attributes.should include(Parent.attributes.reject { |k| k == :name })
      end
      it "should include overriden attributes" do
        attributes.should include(:name)
      end
      it "should include overriden attributes with corect options" do
        attributes[:name].type.should == Attrio::Types::Symbol
      end

      it "should include not overriden collections" do
        collections.should include(Parent.collections.reject { |k| k ==
            :friends
        })
      end
      it "should include overriden collections" do
        collections.should include(:friends)
      end
      it "should include overriden collections with corect options" do
        collections[:friends].type.should == Attrio::Types::Symbol
      end

    end
  end
end