# -*- coding: utf-8 -*-

require 'fileutils'

module Agharta
  module Tasks
    class Edit < Thor::Group
      Tasks.register self

      def self.banner
        'agharta edit [recipe]'
      end

      desc 'open or edit recipe'

      argument :recipe_name, :optional => true

      def setup
        unless recipe_name
          self.class.help(shell)
          exit 0
        end
        unless File.exists?(Agharta.recipe_dir)
          FileUtils.mkdir_p(Agharta.recipe_dir)
        end
      end

      def edit
        system Agharta.editor, Agharta.find_recipe(recipe_name)
      end
    end
  end
end
