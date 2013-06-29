require 'spec_helper'

describe Attrio::Collection::Hash do
  context "Basic properties" do
    let(:collection){Attrio::Collection::Hash.new(:test, Fixnum, {})}
    it{ collection.should be}
    it{ collection.should be_kind_of Hash}
    it{collection.class.ancestors.should include(::Attrio::Readable)}
    it{collection.class.ancestors.should include(::Attrio::Collectable)}
    it "should act like a hash" do
      collection[:a] = 1
      collection[:b] = 2
      collection.should eq({a: 1, b: 2})
    end

  end
end