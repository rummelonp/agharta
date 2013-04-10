# -*- coding: utf-8 -*-

require 'agharta/tasks/actions'
require 'thor/group'

module Agharta
  module Tasks
    class UserList < Thor::Group
      Tasks.register 'user:list', self

      def self.banner
        'agharta user:list'
      end

      include Actions

      desc 'show user list'

      def setup
        @users = env.config[:twitter] || {}
        @default = @users.delete(:default)
      end

      def user_list
        if @users.empty?
          say 'No users'
        else
          @users.each do |screen_name, config|
            if screen_name == @default
              say "* #{screen_name}"
            else
              say "  #{screen_name}"
            end
          end
          say "(#{@users.size} users)"
        end
      end
    end
  end
end
