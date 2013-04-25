# -*- coding: utf-8 -*-

require 'agharta/user_stream/client'

module Agharta
  module UserStream
    class Stream < Client
      # Set it to track parameter
      #
      # @see https://dev.twitter.com/docs/api/1.1/get/user
      # @param args [Array<String>]
      def track(*args)
        params[:track] = args.join(',')
      end

      # Set it to location parameter
      #
      # @see https://dev.twitter.com/docs/api/1.1/get/user
      # @param args [Array<String>]
      def locations(*args)
        params[:locations] = args.join(',')
      end

      # Set it to replies parameter
      #
      # @see https://dev.twitter.com/docs/api/1.1/get/user
      # @param value [Symbol]
      def replies(value)
        params[:replies] = value
      end

      # Set all to replies parameter
      #
      # @see https://dev.twitter.com/docs/api/1.1/get/user
      def replies_all
        replies(:all)
      end

      # Set it to with parameter
      #
      # @see https://dev.twitter.com/docs/api/1.1/get/user
      # @param value [Symbol]
      def with(value)
        params[:with] = value
      end

      # Set user to with parameter
      #
      # @see https://dev.twitter.com/docs/api/1.1/get/user
      def with_user
        with(:user)
      end

      # Set followings to with parameter
      #
      # @see https://dev.twitter.com/docs/api/1.1/get/user
      def with_followings
        with(:followings)
      end

      # Execute this stream
      #
      # @override
      def execute
        connection.userstream(params.merge(:method => :post))
      end
    end
  end
end
