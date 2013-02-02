# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    class Sample < Client
      def start
        connection.sample
      end
    end
  end
end
