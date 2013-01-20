# -*- coding: utf-8 -*-

module Agharta
  module Tasks
    module Actions
      def env
        @env ||= Environment.instance
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
