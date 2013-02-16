# -*- coding: utf-8 -*-

module Agharta
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

      def execute
        connection.filter(params)
      end
    end
  end
end
