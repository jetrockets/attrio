require 'spec_helper'

#TODO figure out why this warning is at top of spec results and not for Hash
#/home/scottp/workspace/attrio/spec/unit/collection/set_spec.rb:5: warning: toplevel constant Set referenced by Attrio::Collection::Set
describe Attrio::Collection::Set do
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

end
