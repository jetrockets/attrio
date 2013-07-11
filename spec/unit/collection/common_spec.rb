require 'spec_helper'

describe "Attrio::Collections::Common" do
  let(:init_vals){['foo','bar','baz']}
  let(:options_hash){{:initial_values => init_vals}}
  let(:array_collection) do
    Attrio::Collections::Array.create_collection(String,options_hash)
  end
  let(:set_collection) do
    Attrio::Collections::Set.create_collection(String,options_hash)
  end
  let(:hash_collection) do
    options_hash[:index] = :chr
    Attrio::Collections::Hash.create_collection(String,options_hash)
  end

  describe "#create_collection" do
    it{array_collection.to_a.should == init_vals}
    it{set_collection.  to_a.should == init_vals}
    it{hash_collection. to_a.should == [['f','foo'],['b','baz']]}
  end

  describe "#initial_values" do
    it{array_collection.initial_values.map(&:value).should == init_vals}
    it{set_collection.  initial_values.map(&:value).should == init_vals}
    it{hash_collection. initial_values.map(&:value).should == init_vals}
  end

  describe "#empty_element" do
    it{array_collection.empty_collection.to_a.should == []}
    it{set_collection.  empty_collection.to_a.should == []}
    it{hash_collection. empty_collection.to_a.should == []}
  end

  describe "#initialize_collection" do
    before(:each) do
      array_collection.empty_collection
      set_collection.  empty_collection
      hash_collection. empty_collection
    end

    it{array_collection.initialize_collection.to_a.should == init_vals}
    it{set_collection.  initialize_collection.to_a.should == init_vals}
    it{hash_collection. initialize_collection.to_a.should == [['f','foo'],['b','baz']]}
  end

  describe "#reset_collection" do
    before(:each) do
      array_collection.empty_collection.add_element("test")
      set_collection.  empty_collection.add_element("test")
      hash_collection. empty_collection.add_element("test")
    end

    it{array_collection.reset_collection.to_a.should == init_vals}
    it{set_collection.  reset_collection.to_a.should == init_vals}
    it{hash_collection. reset_collection.to_a.should == [['f','foo'],['b','baz']]}
  end
end