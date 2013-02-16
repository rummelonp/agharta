# -*- coding: utf-8 -*-

puts 'Welcome to Agharta!'

if env.config[:twitter].nil?
  Agharta::Tasks::UserAdd.start
end

sample {
  credentials :default

  log STDOUT
  log 'sample.log'

  user {
    all!
  }
}
