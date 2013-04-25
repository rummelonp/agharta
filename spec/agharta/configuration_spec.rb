# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::Configuration do
  before(:all) do
    @default_credentials = {
      :consumer_key       => 'DCK',
      :consumer_secret    => 'DCS',
      :oauth_token        => 'DOT',
      :oauth_token_secret => 'DOS',
    }

    @other_credentials = {
      :consumer_key       => 'OCK',
      :consumer_secret    => 'OCS',
      :oauth_token        => 'OOT',
      :oauth_token_secret => 'OOS',
    }

    @options = @default_credentials

    @config = {
      :twitter => {
        :default  => :mitukiii,
        :mitukiii => @default_credentials,
        :other    => @other_credentials,
      },
    }
  end

  before do
    @recipe = DummyRecipe.new
    @recipe.env.stub(:config).and_return(@config)
  end

  describe '#env' do
    it 'should be a Agharta::Environment' do
      @recipe.env.should be_a Agharta::Environment
    end
  end

  describe '#set' do
    context 'when given key and value' do
      before do
        @options.each do |key, value|
          @recipe.set(key, value)
        end
      end

      it 'should set it to configuration' do
        @options.each do |key, value|
          @recipe.send(key).should == value
        end
      end
    end

    context 'when given a hash' do
      before do
        @recipe.set(@options)
      end

      it 'should set it to configuration as key value configuration' do
        @options.each do |key, value|
          @recipe.send(key).should == value
        end
      end
    end
  end

  describe '#options' do
    before do
      @recipe.set(@options)
    end

    it 'should return current configuration by a hash' do
      @recipe.options.should == @options
    end
  end

  describe '#credentials' do
    before do
    end

    context 'when not given args' do
      context 'when credentials not set' do
        before do
          @recipe.should_receive(:default_credentials).once
        end

        it 'should call #default_credentials' do
          @recipe.credentials == @default_credentials
        end
      end

      context 'when credentials have been set' do
        before do
          @recipe.set(@other_credentials)
          @recipe.should_receive(:build_credentials).at_least(:once).and_call_original
        end

        it 'should call #build_credentials' do
          @recipe.credentials == @other_credentials
        end
      end
    end

    context 'when given args' do
      before do
        @recipe.should_receive(:set_credentials).with(:default).once
      end

      it 'should call #set_credentials' do
        @recipe.credentials(:default) == @default_credentials
      end
    end
  end

  describe '#build_credentials' do
    before do
      @recipe.set(@other_credentials)
    end

    it 'should return current credentials configuration by a hash' do
      @recipe.build_credentials.should == @other_credentials
    end
  end

  describe '#default_credentials' do
    before do
      @recipe.set(@other_credentials)
    end

    it 'should return default credentials configuration by a hash' do
      @recipe.default_credentials.should == @default_credentials
    end
  end

  describe '#set_credentials' do
    context 'when given symbol :default' do
      before do
        @recipe.set_credentials(:default)
      end

      it 'should set default credentials to configuration' do
        @recipe.build_credentials.should == @default_credentials
      end
    end

    context 'when given user name symbol' do
      before do
        @recipe.set_credentials(:other)
      end

      it 'should set given user name credentials to configuration' do
        @recipe.build_credentials.should == @other_credentials
      end
    end
  end
end
