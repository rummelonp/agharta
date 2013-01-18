# -*- coding: utf-8 -*-

require 'agharta/tasks/environment'

module Agharta
  module Tasks
    module Actions
      def env
        @env ||= Environment
      end

      def help
        self.class.help(shell)
        exit
      end

      def error(message)
        shell.error(message)
        exit false
      end
    end
  end
end
