# -*- coding: utf-8 -*-

require 'thor/group'

module Agharta
  module Tasks
    def self.mappings
      @mappings ||= {}
    end

    def self.register(klass)
      mappings[klass.name.split('::').last.downcase] = klass
    end

    class Cli < Thor::Group
      def self.banner
        "#{basename} [task]"
      end

      def self.desc
        tasks = "Tasks:\n"
        Tasks.mappings.each do |k, v|
          tasks << "  #{basename} #{k.to_s.ljust(10)} # #{v.desc}\n"
        end

        tasks
      end

      def setup
        task_name = ARGV.shift.to_s.downcase
        if task = Tasks.mappings[task_name]
          task.start ARGV
        else
          self.class.help(shell)
        end
      end
    end

    class Edit < Thor::Group
      Tasks.register self

      def self.banner
        "#{basename} [recipe]"
      end

      desc 'open or edit recipe'

      argument :recipe, :optional => true

      def edit
        puts 'Not Implemented Yet.'
      end
    end

    class Execute < Thor::Group
      Tasks.register self

      def self.banner
        "#{basename} [recipe]"
      end

      desc 'execute recipe'

      argument :recipe, :optional => true

      def execute
        puts 'Not Implemented Yet'
      end
    end
  end
end
