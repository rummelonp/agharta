# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    class Stream < Client
      def track(*args)
        params[:track] = args.join(',')
      end

      def locations(*args)
        params[:locations] = args.join(',')
      end

      def replies(value)
        params[:replies] = value
      end

      def replies_all
        replies(:all)
      end

      def with(value)
        params[:with] = value
      end

      def with_user
        with(:user)
      end

      def with_followings
        with(:followings)
      end

      def execute
        connection.userstream(params.merge(:method => :post))
      end
    end
  end
end
