# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    Recipe.register self

    def clients
      @clients ||= []
    end

    def client(client)
      clients << client
      client
    end

    def stream(options = {}, &block)
      client Stream.new(self, options, &block)
    end

    def filter(options = {}, &block)
      client Filter.new(self, options, &block)
    end

    def sample(options = {}, &block)
      client Sample.new(self, options, &block)
    end
  end
end

require 'agharta/user_stream/hooks'
require 'agharta/user_stream/client'
require 'agharta/user_stream/stream'
require 'agharta/user_stream/filter'
require 'agharta/user_stream/sample'
