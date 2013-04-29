
require 'spec_helper'

describe Agharta::Handleable do
  before(:all) do
    @context = DummyRecipe.new
    Nyan = Class.new do
      include Agharta::Handleable
    end
  end

  before do
    @nyan = Nyan.new(@context)
  end

  describe '#call' do
    it 'should raise NotImplementedError' do
      expect { @nyan.call({}) }.to raise_error(NotImplementedError)
    end
  end
end
