# -*- coding: utf-8 -*-

if env.config[:twitter].nil?
  Agharta::Tasks::UserAdd.start
  env.config(reload = true)
end

puts 'Welcome to Agharta!'

filter {
  credentials :default

  track 'twitter', 'tumblr', 'facebook'

  user {
    all!
    log $stdout
    log 'filter.user.log'
  }
}
