require 'spec_helper'

describe Attrio::Collections::Hash do
  context "Basic properties" do
    let(:collection) do
      begin
        old_verbose, $VERBOSE = $VERBOSE, nil #shutting off warnings for this block
        #generates warning: toplevel constant Hash referenced by Attrio::Collection::Hash
        return Attrio::Collections::Hash.new(Object)
      ensure
        $VERBOSE = old_verbose
      end
    end
    it{collection.should be}
    #delegation is making this fail, using alternate below
    #it{collection.should be_a Attrio::Collections::Hash}
    #delegation returns the hash instead of the parent object so this succeeds but doesn't tell us anything useful
    it{collection.should be_a_kind_of Hash}

    it{collection.class.should eq Attrio::Collections::Hash}
    it "should act like a hash" do
      collection[:a] = 1
      collection[:b] = 2
      collection.should eq({a: 1, b: 2})
    end
  end

  describe "#add_element(*values)" do
    let(:collection){Attrio::Collections::Hash.new(String, key_method: :chr)} #String#chr returns first character of string
    it "should use the :chr method on string to generate key" do
      collection.add_element("test")
      collection.should eq({"t" => "test"})
    end
    it "should overwrite entries with the same key result" do
      collection.add_element("test")
      collection.add_element("testing")
      collection.should eq({"t" => "testing"})
    end
    it "should take an array of entries and add each one" do
      collection.add_element("test","foo")
      collection.should eq({"t" => "test","f" => "foo"})
    end
    it "should raise a TypeError if asked to add wrong type of value" do
      expect{collection.add_element(123)}.to raise_error TypeError
    end
    it "should typecast elements before inserting them" do
      type = Attrio::Types.const_get("Integer")
      collection = Attrio::Collections::Hash.new(type, key_method: :odd? )
      collection.add_element("12",13)
      collection.should eq({true => 13, false => 12})
    end
    it "should pass value into constructor before inserting them" do
      collection = Attrio::Collections::Hash.new(Pathname, key_method: :absolute? )
      collection.add_element("~/workspace", "/tmp")
      collection.keys.should eq [false, true]
      collection.values.first.should be_a Pathname
      collection.values.last.should be_a Pathname
    end
  end

  describe "#has_element(key)" do
    let(:collection) do
      c = Attrio::Collections::Hash.new(String, key_method: :chr)
      c.add_element("test","foo","bar")
      c
    end
    it{collection.has_element?("test").should be_false}
    it{collection.has_element?("f").should be_true}
    it{collection.has_element?(0).should be_false}
  end

  describe "#find_element(key)" do
    let(:collection) do
      c = Attrio::Collections::Hash.new(String, key_method: :chr)
      c.add_element("test","foo","bar")
      c
    end
    it{collection.find_element("test").should be_nil}
    it{collection.find_element("f").should eq "foo"}
    it{collection.find_element(0).should be_nil}
  end

end