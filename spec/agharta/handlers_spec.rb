# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::Handlers do
  before(:all) do
    DummyHook = Class.new do
      include Agharta::Context
      include Agharta::Handlers
    end
    DummyHandler = Class.new do
      def initialize(context, *args, &block)
      end
    end
    Agharta::Stores.register(:dummy, DummyHandler)
    Agharta::Notifies.register(:dummy, DummyHandler)
  end

  before do
    @hook = DummyHook.new
    @hook.should_receive(:handler).and_call_original
  end

  describe '#store' do
    it 'should add store handler to handlers' do
      @hook.store(:dummy).should be_is_a(DummyHandler)
    end
  end

  describe '#notify' do
    it 'should add notify handler to handlers' do
      @hook.notify(:dummy).should be_is_a(DummyHandler)
    end
  end

  describe '#log' do
    it 'should add log handler to handlers' do
      @hook.log($stdout).should be_is_a(Agharta::Handlers::Log)
    end
  end
end
