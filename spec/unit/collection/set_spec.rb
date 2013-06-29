require 'spec_helper'

describe Attrio::Collection::Set do
  let(:collection){Attrio::Collection::Set.new(:test, Fixnum, {})}
  context "Basic properties" do
    it{collection.should be}
    it{collection.should be_a ::Set}
    it{collection.class.ancestors.should include(::Attrio::Readable)}
    it{collection.class.ancestors.should include(::Attrio::Collectable)}
  end
  it "should act like a set" do
    collection << 1
    collection << 2
    collection << 1
    collection.to_a.should eq [1,2]
  end

end