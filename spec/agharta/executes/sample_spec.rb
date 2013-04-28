# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::Executes::Sample do
  before do
    @context = DummyRecipe.new
    @sample = Agharta::Executes::Sample.new(@context)
  end

  describe '#execute' do
    before do
      @connection = @sample.send(:connection)
      @sample.stub(:connection).and_return(@connection)
      @connection.should_receive(:sample)
    end

    it 'should call TweetStream#sample' do
      @sample.execute
    end
  end
end
