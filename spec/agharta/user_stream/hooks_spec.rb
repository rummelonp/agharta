# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::UserStream::Hooks do
  before do
    @context = DummyRecipe.new
    @stream = DummyStream.new(@context)
  end

  before do
    @stream.should_receive(:hook).and_call_original
  end

  describe '#keyword' do
    it 'should add keyword hook to hooks' do
      @stream.keyword.should be_is_a(Agharta::UserStream::Hooks::Keyword)
    end
  end

  describe '#user' do
    it 'should add user hook to hooks' do
      @stream.user.should be_is_a(Agharta::UserStream::Hooks::User)
    end
  end

  describe '#event' do
    it 'should add event hook to hooks' do
      @stream.event.should be_is_a(Agharta::UserStream::Hooks::Event)
    end
  end
end
