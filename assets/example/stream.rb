# -*- coding: utf-8 -*-

puts 'Welcome to Agharta!'

if env.config[:twitter].nil?
  Agharta::Tasks::UserAdd.start
end

stream {
  credentials :default

  log STDOUT
  log 'stream.log'

  user {
    all!
  }

  event {
    on :reply
    on :retweet
    on :direct_message
    on :favorite
    on :follow
    on :list_member_added
    on :list_user_subscribed
  }
}
