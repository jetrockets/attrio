require 'spec_helper'

#TODO figure out why this warning is at top of spec results and not for Hash
#/home/scottp/workspace/attrio/spec/unit/collection/set_spec.rb:5: warning: toplevel constant Set referenced by Attrio::Collection::Set
describe Attrio::Collection::Set, focus: true  do
  let(:collection) do
    begin
      old_verbose, $VERBOSE = $VERBOSE, nil #shutting off warnings for this block
      #generates warning: toplevel constant Set referenced by Attrio::Collection::Set
      Attrio::Collections::Set.new(Object, {})
    ensure
      $VERBOSE = old_verbose
    end
  end
  context "Basic properties" do
    it{collection.should be}
    it{collection.should be_a Set}
  end
  it "should act like a set" do
    collection << 1
    collection << 2
    collection << 1
    collection.to_a.should eq [1,2]
  end

  describe "#add_element(*values)" do
    let(:collection){Attrio::Collections::Set.new(String, {})} #String#chr returns first character of string
    it "should use the :chr method on string to generate key" do
      collection.add_element("test")
      collection.to_a.should eq ["test"]
    end
    it "should only add a goven element once" do
      collection.add_element("test")
      collection.add_element("test")
      collection.to_a.should eq ["test"]
    end
    it "should take an array of entries and add each one" do
      collection.add_element("test","foo")
      collection.to_a.should eq ["test","foo"]
    end
    it "should raise a TypeError if asked to add wrong type of value" do
      expect{collection.add_element(123)}.to raise_error TypeError
    end
    it "should typecast elements before inserting them" do
      type = Attrio::Types.const_get("Integer")
      collection = Attrio::Collections::Set.new(type, {})
      collection.add_element("12",13)
      collection.to_a.should eq [12,13]
    end
    it "should pass value into constructor before inserting them" do
      collection = Attrio::Collections::Set.new(Pathname,{})
      collection.add_element("~/workspace", "/tmp")
      collection.to_a.should eq [Pathname.new("~/workspace"), Pathname.new("/tmp")]
    end
  end

  describe "#has_element(key)" do
    let(:collection) do
      c = Attrio::Collections::Set.new(String,{})
      c.add_element("test","foo","bar")
      c
    end
    it{collection.has_element?("test").should be_true}
    it{collection.has_element?("f").should be_false}
    it{collection.has_element?(0).should be_false}
  end

  describe "#find_element(key)" do
    let(:collection) do
      c = Attrio::Collections::Set.new(String,{})
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
      collection = Attrio::Collections::Set.new(Object,{})
      element_one = klass.new(123,234)
      element_two = klass.new(123,789)
      collection.add_element(element_one)
      collection.add_element(element_two)
      collection.find_element(element_two).should be element_one
    end

  end
end
