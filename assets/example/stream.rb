# -*- coding: utf-8 -*-

puts 'Welcome to Agharta!'

if env.config[:twitter].nil?
  Agharta::Tasks::UserAdd.start
end

stream {
  credentials :default

  log STDOUT
}
