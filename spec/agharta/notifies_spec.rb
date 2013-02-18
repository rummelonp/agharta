# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::Notifies do
  before(:all) do
    DummyHandler = Class.new
    Agharta::Notifies.register(:dummy, DummyHandler)
  end

  describe '#find' do
    context 'with notify name' do
      it 'should return notify adapter' do
        Agharta::Notifies.find(:dummy).should be_is_a(Class)
      end
    end

    context 'with given a invalid notify name' do
      it 'should raise ArgumentError' do
        lambda { Agharta::Notifies.find(:invalid) }.should raise_error(ArgumentError)
      end
    end
  end
end
