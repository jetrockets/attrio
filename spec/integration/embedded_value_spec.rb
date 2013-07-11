require 'spec_helper'

describe 'Embedded Value' do
  before do
    module MassAssignment
      def initialize(attributes = {})
        self.attributes = attributes
      end

      def attributes=(attributes = {})
        attributes.each do |attr,value|
          self.send("#{attr}=", value) if self.respond_to?("#{attr}=")
          self.send("add_#{attr}", value) if self.respond_to?("add_#{attr}")
        end
      end
    end

    class Bar
      include Attrio
      include MassAssignment

      define_attributes do
        attr :name, String
        attr :capacity, Integer, default: 25
      end
    end

    class City
      include Attrio
      include MassAssignment

      define_attributes do
        attr :name, String
        collection :streets, String, :unique => true
        collection :bars, Bar, :unique => true, :index => :name
      end
    end

    class Address
      include Attrio
      include MassAssignment

      define_attributes do
        attr :street,  String
        attr :zipcode, String
        attr :city,    City
      end
    end

    class User
      include Attrio
      include MassAssignment

      define_attributes do
        attr :name,    String
        attr :address, Address
      end
    end
  end

  let(:bar_attributes) do
    [{:name => "Corner Pub"},
     {:name => "Dive",:capacity => 10 }]
  end

  let(:address_attributes) do
      { :street => 'Sklizkova 6A', :zipcode => '170000',
        :city => { :name => 'Tver', :streets => ['Sklizkova', 'main'],
                   :bars => bar_attributes} }
  end

  it 'should allow to pass a hash for the embedded value' do
    user = User.new
    user.address = address_attributes
    user.address.street.should == 'Sklizkova 6A'
    user.address.zipcode.should == '170000'
    user.address.city.name.should == 'Tver'
    user.address.city.streets.to_a.should == ['Sklizkova', 'main']
    user.address.city.bars["Dive"].capacity.should == 10
    user.address.city.bars["Corner Pub"].capacity.should == 25
  end
end