# -*- coding: utf-8 -*-

module Agharta
  module Tasks
    class UserDefault < Thor::Group
      Tasks.register 'user:default', self

      def self.banner
        'agharta user:default [user_name]'
      end

      include Actions

      desc 'change default user'

      argument :user_name, :optional => true

      def setup
        help unless user_name
        @config = env.config
        @users = @config[:twitter] || {}
      end

      def user_default
        if @users.empty?
          say 'No users'
        elsif @users[user_name.to_sym].nil?
          say "No such user \"#{user_name}\""
        else
          @users[:default] = user_name.to_sym
        end
      end

      def teardown
        YAML.dump(@config, open(env.config_path, 'w'))
        say "Set #{user_name} to default"
      end
    end
  end
end
