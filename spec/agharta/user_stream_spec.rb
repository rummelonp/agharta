# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::UserStream do
  before do
    @recipe = DummyRecipe.new
    @recipe.should_receive(:executable).and_call_original
  end

  describe '#stream' do
    it 'should add stream client to executable' do
      @recipe.stream.should be_is_a(Agharta::UserStream::Stream)
    end
  end

  describe '#filter' do
    it 'should add filter client to executable' do
      @recipe.filter.should be_is_a(Agharta::UserStream::Filter)
    end
  end

  describe '#sample' do
    it 'should add sample client to executable' do
      @recipe.sample.should be_is_a(Agharta::UserStream::Sample)
    end
  end
end
