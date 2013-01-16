# -*- coding: utf-8 -*-

module Agharta
  module Tasks
    module Actions
      def env
        Environment
      end

      def exit_with_help
        self.class.help(shell)
        exit
      end

      def exit_with_error(message)
        shell.error(message)
        exit false
      end
    end
  end
end
