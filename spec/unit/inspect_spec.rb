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
      object.method(:inspect).source_location.first.should match(/lib\/attrio\/inspect.rb/)
    end
  end

  context ':inspect option passed' do
    let(:model) do
      Class.new do
        include Attrio

        define_attributes :inspect => false do
        end
      end
    end

    let(:object) { model.new }

    it 'should not have inspect defined by attrio' do
      if RUBY_ENGINE == 'rbx'
        object.method(:inspect).source_location.first.should_not match(/attrio/)
      else
        object.method(:inspect).source_location.should be_nil
      end                
    end
  end
end