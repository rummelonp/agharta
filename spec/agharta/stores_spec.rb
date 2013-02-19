# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::Stores do
  before(:all) do
    Agharta::Stores.register(:dummy, DummyHandler)
  end

  describe '#find' do
    context 'with store name' do
      it 'should return store adapter' do
        Agharta::Stores.find(:dummy).should be_is_a(Class)
      end
    end

    context 'with given a invalid store name' do
      it 'should raise ArgumentError' do
        lambda { Agharta::Stores.find(:invalid) }.should raise_error(ArgumentError)
      end
    end
  end
end
