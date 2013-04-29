# -*- coding: utf-8 -*-

require 'faraday'
require 'agharta/configuration'
require 'agharta/connection'
require 'agharta/errors'
require 'agharta/handleable'
require 'agharta/linker'
require 'agharta/status_formatter'

module Agharta
  module Notifies
    class ImKayac
      Notifies.register :im_kayac, self

      include Configuration
      include Handleable

      # @raise [Agharta::ConfigurationError] Error raised when configuration is not enough
      # @overload initialize(context, options = {})
      #   @param context [Agharta::Context]
      #   @param options [Hash]
      #   @option options [String] username (nil) Username of im.kayac.com account
      #   @option options [String] password (nil) Password of im.kayac.com account
      #   @option options [String] secret_key (nil) Secret key of im.kayac.com account
      #   @option options [Symbol] linker (nil) Linker to use to im.kayac.com handler
      def initialize(context, *args, &block)
        config = args.last.is_a?(Hash) ? args.last : {}
        config = (env.config[:im_kayac] || {}).merge(config)
        if config.empty?
          raise ConfigurationError, "Please configuration of \"im_kayac\""
        end
        @username = config[:username]
        @password = config[:password]
        @secret_key = config[:secret_key]
        @linker = Linker.find(config[:linker]).new(context)
      end

      # Push notification to im.kayac.com
      #
      # @override
      # @param status [Hash]
      # @param options [Hash]
      def call(status, options = {})
        data = StatusFormatter.call(status, options)

        params = {
          :message => "#{data[:title]}: #{data[:message]}"
        }

        if @secret_key
          params[:sig] = Digest::SHA1.hexdigest(message + @secret_key)
        elsif @password
          params[:password] = @password
        end

        handler = @linker.call(status, options)
        if handler
          params[:handler] = handler
        end

        post("/api/post/#{@username}", params)
      end

      private
      def connection
        Faraday.new(:url => 'http://im.kayac.com') do |builder|
          builder.response :json
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
        body = env[:body]
        if body['result'].to_s != 'posted' || body['error'].to_s != ''
          raise APIError, error_message(env)
        end
        body
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
        if body['error'].to_s != ''
          body['error']
        else
          'unknwon error'
        end
      end
    end
  end
end
