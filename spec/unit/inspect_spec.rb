require 'spec_helper'

describe Attrio::Inspect do
  context 'without options' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
        end
      end
    end

    let(:object) { model.new }

    it 'should have inspect defined by attrio' do
      expect(object.method(:inspect).source_location.first).to match(/lib\/attrio\/inspect.rb/)
    end
  end
end