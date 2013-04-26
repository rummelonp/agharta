# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::Executes do
  before do
    @recipe = DummyRecipe.new
    @recipe.should_receive(:add_executable).and_call_original
  end

  describe '#stream' do
    it 'should add stream client to executable' do
      @recipe.stream.should be_is_a(Agharta::Executes::Stream)
    end
  end

  describe '#filter' do
    it 'should add filter client to executable' do
      @recipe.filter.should be_is_a(Agharta::Executes::Filter)
    end
  end

  describe '#sample' do
    it 'should add sample client to executable' do
      @recipe.sample.should be_is_a(Agharta::Executes::Sample)
    end
  end
end
