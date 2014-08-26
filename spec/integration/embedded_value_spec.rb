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
        end
      end
    end

    class City
      include Attrio
      include MassAssignment

      define_attributes do
        attr :name, String
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

  let(:address_attributes) do
      { :street => 'Sklizkova 6A', :zipcode => '170000', :city => { :name => 'Tver' } }
  end

  it 'should allow to pass a hash for the embedded value' do
    user = User.new
    user.address = address_attributes
    expect(user.address.street).to eq('Sklizkova 6A')
    expect(user.address.zipcode).to eq('170000')
    expect(user.address.city.name).to eq('Tver')
  end
end