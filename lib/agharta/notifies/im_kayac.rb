# -*- coding: utf-8 -*-

module Agharta
  module Notifies
    class ImKayac
      Notifies.register :im_kayac, self

      include Configuration

      def initialize(context, *args, &block)
        begin
          require 'im-kayac'
        rescue LoadError
          raise LoadError, 'Please install "im-kayac" gem'
        end
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
        message = "#{data[:title]}: #{data[:message]}"

        params = {}

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

        ::ImKayac.post(@username, message, params)
      end
    end
  end
end

require 'agharta/notifies/im_kayac/url_scheme_formatter'
