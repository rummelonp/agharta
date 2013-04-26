# -*- coding: utf-8 -*-

require 'agharta/user_stream'

module Agharta
  module Executes
    class Filter < UserStream
      # Set it to track parameter
      #
      # @see https://dev.twitter.com/docs/api/1.1/post/statuses/filter
      # @param args [Array<String>]
      def track(*args)
        params[:track] = args.join(',')
      end

      # Set it to location parameter
      #
      # @see https://dev.twitter.com/docs/api/1.1/post/statuses/filter
      # @param args [Array<Integer>]
      def locations(*args)
        params[:locations] = args.join(',')
      end

      # Set it to follow parameter
      #
      # @see https://dev.twitter.com/docs/api/1.1/post/statuses/filter
      # @param args [Array<Integer>]
      def follow(*args)
        params[:follow] = args.join(',')
      end

      # Execute this stream
      #
      # @override
      def execute
        connection.filter(params)
      end
    end
  end
end
