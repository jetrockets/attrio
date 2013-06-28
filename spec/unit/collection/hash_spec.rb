require 'spec_helper'

describe Attrio::Collection::Hash do
  context "Basic properties" do
    let(:collection){Attrio::Collection::Hash.new}
    it{ collection.should be}
    it{ collection.should be_kind_of Hash}
    it{ collection[0] = 1;collection.should eq({0=>1})}

  end
end