# -*- coding: utf-8 -*-

require 'spec_helper'

describe Agharta::MultiLogger do
  before do
    @logger = Agharta::MultiLogger.new($stdout, $stderr)
  end

  [:fatal, :error, :warn, :info, :debug].each do |level|
    describe "##{level}" do
      before do
        @logger.instance_variable_get('@loggers').each do |logger|
          logger.should_receive(level).with('message')
        end
      end

      it "should call Logger##{level}" do
        @logger.send(level, 'message')
      end
    end
  end
end
