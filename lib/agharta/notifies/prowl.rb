# -*- coding: utf-8 -*-

require 'prowl'
Prowl_ = Prowl

module Agharta
  module Notifies
    class Prowl
      Notifies.register :prowl, self

      include Configuration

      def initialize(context, *args, &block)
        config = env.config[:prowl]
        unless config
          raise ConfigurationError, "Please configuration of \"prowl\" to \"#{env.config_path}\""
        end
        @apikey = config[:apikey]
        linker_class = Linker.mappings[config[:handler]]
        if linker_class
          @linker = linker_class.new(context)
        end
      end

      def call(status, options = {})
        data = StatusFormatter.call(status, options)

        params = {
          :event => "#{data[:title]}",
          :description => "#{data[:message]}"
        }

        if @linker
          handler = @linker.call(status, options)
          if handler
            params[:url] = handler
          end
        end
        post(params)
      end

      private
      def connection
        Prowl_.new(:apikey => @apikey,
                  :application => "Agharta")
      end

      def post(params = {})
        response = connection.add(params)
        if response != 200
          raise APIError, error_message(response)
        end
        response
      end

      def error_message(response)
        "response code: #{response}"
      end
    end
  end
end
