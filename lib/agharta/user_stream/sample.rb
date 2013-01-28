# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    class Sample < Client
      def start
        tweetstream.sample(&method(:on_status))
      end
    end
  end
end
