require 'spec_helper'

describe Attrio::Collection::Array do
  context "Basic properties" do
    let(:collection){Attrio::Collection::Array.new}
    it{ collection.should be}
    it{ collection.should be_kind_of Array}
    it{ collection[0] = 1;collection.should eq [1]}

  end
end