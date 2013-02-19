
require 'spec_helper'

describe Agharta::UserStream::Sample do
  before do
    Context = Class.new do
      include Agharta::Configuration
    end
    @context = Context.new
    @sample = Agharta::UserStream::Sample.new(@context)
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
