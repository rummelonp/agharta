# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    class Sample < Client
      def execute
        connection.sample
      end
    end
  end
end
