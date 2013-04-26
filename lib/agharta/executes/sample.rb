# -*- coding: utf-8 -*-

require 'agharta/user_stream'

module Agharta
  module Executes
    class Sample < UserStream
      # Execute this stream
      #
      # @override
      def execute
        connection.sample
      end
    end
  end
end
