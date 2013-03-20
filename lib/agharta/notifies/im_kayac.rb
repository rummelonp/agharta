# -*- coding: utf-8 -*-

require 'faraday'
require 'yajl'

module Agharta
  module Notifies
    class ImKayac
      Notifies.register :im_kayac, self

      include Configuration

      def initialize(context, *args, &block)
        config = env.config[:im_kayac]
        unless config
          raise ConfigurationError, "Please configuration of \"im_kayac\" to \"#{env.config_path}\""
        end
        @username = config[:username]
        @password = config[:password]
        @secret_key = config[:secret_key]
        url_scheme_formatter = URLSchemeFormatter.mappings[config[:handler]]
        if url_scheme_formatter
          @url_scheme_formatter = url_scheme_formatter.new(context)
        end
      end

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

        if @url_scheme_formatter
          handler = @url_scheme_formatter.call(status, options)
          if handler
            params[:handler] = handler
          end
        end

        post("/api/post/#{@username}", params)
      end

      private
      def connection
        Faraday.new(:url => 'http://im.kayac.com') do |builder|
          builder.request :url_encoded
          builder.adapter :net_http
        end
      end

      def post(path, params = {})
        response = connection.post(path, params)
        env = response.env
        body = Yajl.load(env[:body])
        env[:body] = body
        if env[:status] != 200
          raise APIError, error_message(env)
        end
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

require 'agharta/notifies/im_kayac/url_scheme_formatter'
