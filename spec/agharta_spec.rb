# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta do
  describe '.new' do
    it 'should return a Agharta::Recipe' do
      Agharta.new.should be_a Agharta::Recipe
    end
  end
end
