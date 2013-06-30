require 'spec_helper'

#TODO figure out why this warning is at top of spec results and not for hash
#/home/scottp/workspace/attrio/spec/unit/collection/array_spec.rb:3: warning: toplevel constant Array referenced by Attrio::Collection::Array
describe Attrio::Collection::Array do
  let(:collection) do
    begin
      old_verbose, $VERBOSE = $VERBOSE, nil #shutting off warnings for this block
      #generates warning: toplevel constant Set referenced by Attrio::Collection::Set
      Attrio::Collections::Array.new(Object,{})
    ensure
      $VERBOSE = old_verbose
    end
  end
  context "Basic properties" do
    it{collection.should be}
    it{collection.should be_a Array}
  end
  it "should act like an array" do
    collection << 1
    collection << 2
    collection.should eq [1,2]
    collection.reverse.should eq [2,1]
  end
end