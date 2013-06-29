require 'spec_helper'

describe Attrio::Collection::Array do
  let(:collection){Attrio::Collection::Array.new(:test,Fixnum,{})}
  context "Basic properties" do
    it{collection.                should be}
    it{collection.                should be_kind_of Array}
    it{collection.class.ancestors.should include(::Attrio::Readable)}
    it{collection.class.ancestors.should include(::Attrio::Collectable)}
  end
  it "should act like an array" do
    collection << 1
    collection << 2
    collection.should eq [1,2]
    collection.reverse.should eq [2,1]
  end
end