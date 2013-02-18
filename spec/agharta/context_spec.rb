# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::Context do
  before(:all) do
    Nyan = Module.new
    Nyan::Wan = Class.new do
      include Agharta::Context
    end
  end

  before do
    @wan = Nyan::Wan.new
  end

  describe '#name' do
    it 'should return class name by downcase string' do
      @wan.name.should == 'wan'
    end
  end
end
