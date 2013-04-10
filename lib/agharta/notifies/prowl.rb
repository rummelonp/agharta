# -*- coding: utf-8 -*-

require 'faraday'
require 'agharta/configuration'
require 'agharta/connection'
require 'agharta/errors'
require 'agharta/linker'
require 'agharta/status_formatter'

module Agharta
  module Notifies
    class Prowl
      Notifies.register :prowl, self

      include Configuration

      def initialize(context, *args, &block)
        config = args.last.is_a?(Hash) ? args.last : {}
        config = (env.config[:prowl] || {}).merge(config)
        if config.empty?
          raise ConfigurationError, "Please configuration of \"prowl\""
        end
        @apikey = config[:apikey]
        @application = config[:application] || 'Agharta'
        @linker = Linker.find(config[:linker]).new(context)
      end

      def call(status, options = {})
        data = StatusFormatter.call(status, options)

        params = {
          :application => @application,
          :apikey => @apikey,
          :event => data[:title],
          :description => data[:message],
        }

        url = @linker.call(status, options)
        if url
          params[:url] = url
        end

        post('/publicapi/add', params)
      end

      private
      def connection
        Faraday.new(:url => 'https://api.prowlapp.com') do |builder|
          builder.response :xml
          builder.request :url_encoded
          builder.adapter :net_http
        end
      end

      def post(path, params = {})
        response = connection.post(path, params)
        env = response.env
        if env[:status] != 200
          raise APIError, error_message(env)
        end
        env[:body]
      end

      def error_message(env)
        [
          env[:method].to_s.upcase,
          env[:url].to_s,
          env[:status],
          error_body(env[:body]),
        ].join(': ')
      end

      def error_body(body)
        if body['prowl'] && body['prowl']['error'] && body['prowl']['error']['__content__']
          body['prowl']['error']['__content__']
        else
          'Unknown Error'
        end
      end
    end
  end
end
