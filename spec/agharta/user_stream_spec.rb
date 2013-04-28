# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::UserStream do
  before do
    @context = DummyRecipe.new
    @stream = Agharta::UserStream.new(@context)
    @client = Twitter::Client.new
    Twitter::Client.stub(:new).and_return(@client)
  end

  describe '#log_path' do
    it 'should build from context name' do
      File.basename(@stream.log_path).should == 'dummyrecipe.log'
    end
  end

  describe '#logger' do
    it 'should be a MultiLogger' do
      @stream.logger.should be_a Agharta::MultiLogger
    end
  end

  describe '#current_user' do
    it 'should call Twitter::Client#verify_credentials' do
      @client.should_receive(:verify_credentials)
      @stream.current_user
    end
  end
end
