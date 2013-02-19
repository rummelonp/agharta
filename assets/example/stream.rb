# -*- coding: utf-8 -*-

if env.config[:twitter].nil?
  Agharta::Tasks::UserAdd.start
  env.config(reload = true)
end

puts 'Welcome to Agharta!'

stream {
  credentials :default

  user {
    all!
    log $stdout
    log 'stream.user.log'
  }

  event {
    all!
    log $stdout
    log 'stream.event.log'
  }
}
