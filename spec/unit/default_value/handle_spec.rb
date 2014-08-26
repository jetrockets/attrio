require 'spec_helper'

describe Attrio::DefaultValue::Base, '.handle' do
  subject { described_class.handle(double('attribute'), default) }

  context 'when default is a symbol' do
    let(:default) { :symbol }

    it { is_expected.to be_instance_of(Attrio::DefaultValue::Symbol)  }
  end

  context 'when default is a callable' do
    let(:default) { Proc.new {} }

    it { is_expected.to be_instance_of(Attrio::DefaultValue::Callable)  }
  end

  context 'when default is a clonable' do
    let(:default) { "I can be cloned" }

    it { is_expected.to be_instance_of(Attrio::DefaultValue::Clonable)  }
  end

  context 'when default is not clonable' do
    let(:default) { 1 }

    it { is_expected.to be_nil }
  end
end
