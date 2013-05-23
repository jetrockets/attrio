require 'spec_helper'

describe "DefaultValue" do
  context "without 'default' option" do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
          attr :attribute, Date
        end
      end
    end

    let(:object){ model.new }
    
    it "should set variable to nil" do
      object.attribute.should be_nil
    end
  end

  context "without 'default' option" do
    context 'with not typecasted assignment' do
      let(:model) do
        Class.new do
          include Attrio

          define_attributes do
            attr :attribute, Date, :default => Date.today.to_s
          end
        end
      end

      let(:object){ model.new }

      it "should set variable to default value" do
        object.attribute.should == Date.today
      end
    end

    context 'with typecasted assignment' do
      let(:model) do
        Class.new do
          include Attrio

          define_attributes do
            attr :attribute, Date, :default => Date.today
          end
        end
      end

      let(:object){ model.new }

      it "should set variable to default value" do
        object.attribute.should == Date.today
      end
    end
  end

end