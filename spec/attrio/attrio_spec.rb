require 'spec_helper'

describe Attrio do
  describe 'model' do
    let(:model) do
      Class.new { include Attrio }
    end

    it 'should respond_to define_attributes' do
      model.respond_to?(:define_attributes).should be_true
    end

    context 'without options' do
      let(:model) do
        Class.new do
          include Attrio

          define_attributes do
          end
        end
      end

      it 'should respond_to attributes' do
        model.respond_to?(:attributes).should be_true
      end

      it 'should respond_to attributes=' do
        model.respond_to?(:attributes=).should be_true
      end

      describe 'object' do
        let(:object) { model.new }

        it 'should respond_to reset_attributes' do
          object.respond_to?(:reset_attributes).should be_true
          object.respond_to?(:reset_attributes!).should be_true
        end
      end
    end

    context 'with option :as' do
      let(:model) do
        Class.new do
          include Attrio

          define_attributes :as => :model_attributes do
          end
        end
      end

      it 'should respond_to model_attributes' do
        model.respond_to?(:model_attributes).should be_true
      end

      it 'should respond_to model_attributes=' do
        model.respond_to?(:model_attributes=).should be_true
      end

      describe 'object' do
        let(:object) { model.new }

        it 'should respond_to reset_model_attributes' do
          object.respond_to?(:reset_model_attributes).should be_true
          object.respond_to?(:reset_model_attributes!).should be_true
        end
      end
    end
  end
end