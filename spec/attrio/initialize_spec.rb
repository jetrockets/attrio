require 'spec_helper'

describe Attrio::Initialize do
  let(:model) do
    Class.new do
      include Attrio

      define_attributes do
        attr :without_default, Integer
        attr :with_default, String, :default => "default"
      end
    end
  end

  let(:object){ model.new }
  
  context "without 'default' option" do
    it "should set variable to nil" do
      object.without_default.should be_nil
    end
  end

  context "with 'default' option" do
    it "should set variable to default value" do
      object.with_default.should == 'default'
    end
  end

end