require 'spec_helper'

describe Attrio::Collections::Array do
  let(:collection){Attrio::Collections::Array.create_collection(Object,{})}

  context "Basic properties" do
    it{collection.should be}
    it{collection.should be_a Array}
  end
  it "should act like an array" do
    collection << 1
    collection << 2
    collection.should eq [1,2]
    collection.reverse.should eq [2,1]
  end
  
  describe "#add_element(*values)" do
    let(:collection){Attrio::Collections::Array.create_collection(String, {})} #String#chr returns first character of string
    it "should use the :chr method on string to generate key" do
      collection.add_element("test")
      collection.to_a.should eq ["test"]
    end
    it "should add elements" do
      collection.add_element("test")
      collection.add_element("test")
      collection.to_a.should eq ["test","test"]
    end
    it "should take an array of entries and add each one" do
      collection.add_element("test","foo","test")
      collection.to_a.should eq ["test","foo","test"]
    end
    it "should raise a TypeError if asked to add wrong type of value" do
      expect{collection.add_element(123)}.to raise_error TypeError
    end
    it "should typecast elements before inserting them" do
      type = Attrio::Types.const_get("Integer")
      collection = Attrio::Collections::Array.create_collection(type, {})
      collection.add_element("12",13)
      collection.to_a.should eq [12,13]
    end
    it "should pass value into constructor before inserting them" do
      collection = Attrio::Collections::Array.create_collection(Pathname,{})
      collection.add_element("~/workspace", "/tmp")
      collection.to_a.should eq [Pathname.new("~/workspace"), Pathname.new("/tmp")]
    end
  end
  describe "#has_element(key)" do
    let(:collection) do
      c = Attrio::Collections::Array.create_collection(String,{})
      c.add_element("test","foo","bar")
      c
    end
    it{collection.has_element?("test").should be_true}
    it{collection.has_element?("f").should be_false}
    it{collection.has_element?(0).should be_false}
  end

  describe "#find_element(key)" do
    let(:collection) do
      c = Attrio::Collections::Array.create_collection(String,{})
      c.add_element("test","foo","bar")
      c
    end
    it{collection.find_element("test").should eq "test"}
    it{collection.find_element("f").should be_nil}
    it "should return the exact object" do
      klass = Struct.new(:foo,:bar) do
        def ==(other)
          foo == other.foo
        end
      end
      collection = Attrio::Collections::Array.create_collection(Object,{})
      element_one = klass.new(123,234)
      element_two = klass.new(123,789)
      collection.add_element(element_one)
      collection.add_element(element_two)
      collection.find_element(element_two).should be element_one
    end
  end
end