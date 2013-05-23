require 'spec_helper'

describe "Type" do
  context '' do
    context '' do
      let(:model) do
        Class.new do
          include Attrio

          define_attributes do
            attr :attribute, Integer
          end
        end
      end

      let(:object) { model.new }

      it 'should' do
        object.attribute = 10
        object.attribute.is_a?(Integer).should be_true
      end

      it 'should' do
        object.attribute = 'string'
        object.attribute.should == 0
      end
    end

    context '' do
      let(:model) do
        Class.new do
          include Attrio

          define_attributes do
            attr :attribute, 'integer'
          end
        end
      end

      let(:object) { model.new }

      it 'should' do
        object.attribute = 10
        object.attribute.is_a?(Integer).should be_true
      end

      it 'should' do
        object.attribute = 'string'
        object.attribute.should == 0
      end
    end

    context '' do
      let(:model) do
        Class.new do
          include Attrio

          define_attributes do
            attr :attribute, :integer
          end
        end
      end

      let(:object) { model.new }

      it 'should' do
        object.attribute = 10
        object.attribute.is_a?(Integer).should be_true
      end

      it 'should' do
        object.attribute = 'string'
        object.attribute.should == 0
      end
    end
  end

  context '' do
    context '' do
      let(:model) do
        Class.new do
          include Attrio

          define_attributes do
            attr :attribute, :type => Integer
          end
        end
      end

      let(:object) { model.new }

      it 'should' do
        object.attribute = 10
        object.attribute.is_a?(Integer).should be_true
      end

      it 'should' do
        object.attribute = 'string'
        object.attribute.should == 0
      end
    end

    context '' do
      let(:model) do
        Class.new do
          include Attrio

          define_attributes do
            attr :attribute, :type => 'integer'
          end
        end
      end

      let(:object) { model.new }

      it 'should' do
        object.attribute = 10
        object.attribute.is_a?(Integer).should be_true
      end

      it 'should' do
        object.attribute = 'string'
        object.attribute.should == 0
      end
    end

    context '' do
      let(:model) do
        Class.new do
          include Attrio

          define_attributes do
            attr :attribute, :type => :integer
          end
        end
      end

      let(:object) { model.new }

      it 'should' do
        object.attribute = 10
        object.attribute.is_a?(Integer).should be_true
      end

      it 'should' do
        object.attribute = 'string'
        object.attribute.is_a?(Integer).should be_true
        object.attribute.should == 0
      end
    end
  end
end