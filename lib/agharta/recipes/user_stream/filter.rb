# -*- coding: utf-8 -*-

module Agharta
  module Recipes
    module UserStream
      class Filter < Client
        def track(*args)
          params[:track] = args.join(',')
        end

        def locations(*args)
          params[:locations] = args.join(',')
        end

        def follow(*args)
          params[:follow] = args.join(',')
        end

        def start
          tweetstream.filter(params, &method(:on_status))
        end
      end
    end
  end
end
