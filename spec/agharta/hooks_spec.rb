# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::Hooks do
  before do
    @executable = DummyExecutable.new
    @executable.should_receive(:add_hook).and_call_original
  end

  describe '#keyword' do
    it 'should add keyword hook to hooks' do
      @executable.keyword.should be_is_a(Agharta::Hooks::Keyword)
    end
  end

  describe '#user' do
    it 'should add user hook to hooks' do
      @executable.user.should be_is_a(Agharta::Hooks::User)
    end
  end

  describe '#event' do
    it 'should add event hook to hooks' do
      @executable.event.should be_is_a(Agharta::Hooks::Event)
    end
  end
end
