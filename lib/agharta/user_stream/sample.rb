# -*- coding: utf-8 -*-

require 'agharta/user_stream/client'

module Agharta
  module UserStream
    class Sample < Client
      # Execute this stream
      def execute
        connection.sample
      end
    end
  end
end
