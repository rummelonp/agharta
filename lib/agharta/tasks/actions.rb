# -*- coding: utf-8 -*-

require 'agharta/environment'

module Agharta
  module Tasks
    module Actions
      # @return [Agharta::Environment]
      def env
        @env ||= Environment.instance
      end

      # Show help & exit command
      def help
        self.class.help(shell)
        exit
      end

      # Show error message & exit command
      #
      # @param message [String]
      def error(message)
        shell.error(message)
        exit false
      end
    end
  end
end
