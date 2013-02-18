# -*- coding: utf-8 -*-

require 'spec_helper'

describe String do
  before do
    @message = '@mitukiii nyan'
  end

  describe '#auto_color' do
    it 'should return colorized string' do
      @message.auto_color.should =~ /\e\[[0-9]+m\@mitukiii nyan\e\[0m/
    end
  end

  describe '#colorize' do
    it 'should return colorized string by a pattern' do
      @message.colorize(/@[a-zA-Z0-9_]+/).should =~ /\e\[[0-9]+m\@mitukiii\e\[0m/
    end
  end
end
