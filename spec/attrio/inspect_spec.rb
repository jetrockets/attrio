require 'spec_helper'

describe Attrio::Inspect do
  context '' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes do
        end
      end
    end

    let(:object) { model.new }

    it 'should' do
      object.method(:inspect).source_location.first.should match(/lib\/attrio\/inspect.rb/)
    end
  end

  context '' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes :inspect => false do
        end
      end
    end

    let(:object) { model.new }

    it 'should' do
      object.method(:inspect).source_location.should be_nil
    end
  end
end