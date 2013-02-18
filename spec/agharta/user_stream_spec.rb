# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::UserStream do
  before(:all) do
    Recipe = Class.new do
      include Agharta::Executable
      include Agharta::Configuration
      include Agharta::UserStream
    end
  end

  before do
    @recipe = Recipe.new
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
