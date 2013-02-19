# -*- coding: utf-8 -*-

if env.config[:twitter].nil?
  Agharta::Tasks::UserAdd.start
  env.config(reload = true)
end

puts 'Welcome to Agharta!'

sample {
  credentials :default

  user {
    all!
    log $stdout
    log 'sample.user.log'
  }
}
