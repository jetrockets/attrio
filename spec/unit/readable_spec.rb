require 'spec_helper'

describe Attrio::Readable do
  let(:collection){Attrio::Collection::Hash.new(:test, Fixnum, {})}
  let(:target_class){Class.new}
  context "common methods" do
    it{collection.reader_method_name.should eq :test}
    it{collection.reader_visibility.should eq :public}
    it{collection.instance_variable_name.should eq "@test"}
    it{collection.name.should eq :test}
    it{collection.type.should eq Fixnum}
    it{collection.options.should eq({})}
  end
  it "class definition" do
    collection.define_reader(target_class)
    target_class.instance_methods.should include(:test)
  end

end