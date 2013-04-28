# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::Executes::Stream do
  before do
    @context = DummyRecipe.new
    @stream = Agharta::Executes::Stream.new(@context)
  end

  describe '#track' do
    it 'should set it to track parameter' do
      @stream.track('twitter', 'tumblr')
      @stream.params[:track].should == 'twitter,tumblr'
    end
  end

  describe '#locations' do
    it 'should set it to locations parameter' do
      @stream.locations(-122.75, 36.8, -121.75, 37.8)
      @stream.params[:locations].should == '-122.75,36.8,-121.75,37.8'
    end
  end

  describe '#replies' do
    it 'should set it to replies parameter' do
      @stream.replies :all
      @stream.params[:replies].should == :all
    end
  end

  describe '#replies_all' do
    it 'should set all to replies parameter' do
      @stream.replies_all
      @stream.params[:replies].should == :all
    end
  end

  describe '#with' do
    it 'should set it to with parameter' do
      @stream.with :user
      @stream.params[:with].should == :user
    end
  end

  describe '#with_user' do
    it 'should set user to with parameter' do
      @stream.with_user
      @stream.params[:with].should == :user
    end
  end

  describe '#with_followings' do
    it 'should set followings to with parameter' do
      @stream.with_followings
      @stream.params[:with].should == :followings
    end
  end

  describe '#execute' do
    before do
      @connection = @stream.send(:connection)
      @stream.stub(:connection).and_return(@connection)
      @connection.should_receive(:userstream)
    end

    it 'should call TweetStream#userstream' do
      @stream.execute
    end
  end
end
