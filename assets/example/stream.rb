# -*- coding: utf-8 -*-

puts 'Welcome to Agharta!'

if env.config[:twitter].nil?
  Agharta::Tasks::UserAdd.start
end

stream {
  credentials :default

  user {
    all!
    log STDOUT
    log 'stream.log'
  }

  event {
    all!
    log STDOUT
    log 'stream.log'
  }
}
