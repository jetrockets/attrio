require 'spec_helper'

describe Attrio::DefaultValue::Base, '.handle' do
  subject { described_class.handle(mock('object'), mock('attribute'), default) }

  context 'when default is a symbol' do
    let(:default) { :symbol }

    it { should be_instance_of(Attrio::DefaultValue::Symbol)  }
  end

  context 'when default is a callable' do
    let(:default) { Proc.new {} }

    it { should be_instance_of(Attrio::DefaultValue::Callable)  }
  end

  context 'when default is a clonable' do
    let(:default) { "I can be cloned" }

    it { should be_instance_of(Attrio::DefaultValue::Clonable)  }
  end

  context 'when default is not clonable' do
    let(:default) { 1 }

    it { should be_nil }
  end
end
