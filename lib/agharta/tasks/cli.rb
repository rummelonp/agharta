# -*- coding: utf-8 -*-

module Agharta
  module Tasks
    class Cli < Thor::Group
      def self.banner
        'agharta [task]'
      end

      def self.desc
        tasks = "Tasks:\n"
        Tasks.mappings.each do |k, v|
          tasks << "  agharta #{k.to_s.ljust(10)} # #{v.desc}\n"
        end

        tasks
      end

      def setup
        task_name = ARGV.shift.to_s.downcase
        @task = Tasks.mappings[task_name]
        unless @task
          self.class.help(shell)
          exit 0
        end
      end

      def boot
        @task.start(ARGV)
      end
    end
  end
end
