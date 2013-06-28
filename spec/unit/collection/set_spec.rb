require 'spec_helper'

describe Attrio::Collection::Set do
  context "Basic properties", focus: true do
    let(:a){Attrio::Collection::Set.new}
    it{a.should be}
    it{ a.should be_kind_of Set}
    it{ a.add(1);a.to_a.should eq [1]}

  end
end