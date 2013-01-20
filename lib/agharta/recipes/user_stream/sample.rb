# -*- coding: utf-8 -*-

module Agharta
  module Recipes
    module UserStream
      class Sample < Client
        def start
          tweetstream.sample(&method(:on_status))
        end
      end
    end
  end
end
