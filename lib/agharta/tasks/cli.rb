# -*- coding: utf-8 -*-

module Agharta
  module Tasks
    class Cli < Thor::Group
      def self.banner
        'agharta [task]'
      end

      include Actions

      def self.desc
        tasks = "Tasks:\n"
        Tasks.mappings.each do |k, v|
          tasks << "  #{v.banner.ljust(36)} # #{v.desc}\n"
        end
        tasks
      end

      def setup
        task_name = ARGV.shift.to_s.downcase
        @task = Tasks.mappings[task_name]
        help unless @task
      end

      def boot
        @task.start(ARGV)
      end
    end
  end
end
