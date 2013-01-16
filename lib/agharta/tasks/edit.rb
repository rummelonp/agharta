# -*- coding: utf-8 -*-

require 'fileutils'

module Agharta
  module Tasks
    class Edit < Thor::Group
      Tasks.register self

      def self.banner
        'agharta edit [recipe]'
      end

      include Agharta::Tasks::Actions

      desc 'open or edit recipe'

      argument :recipe_name, :optional => true

      def setup
        exit_with_help unless recipe_name
        unless File.exists?(env.recipe_root)
          FileUtils.mkdir_p(env.recipe_root)
        end
      end

      def edit
        system env.editor, env.recipe_path(recipe_name)
      end
    end
  end
end
