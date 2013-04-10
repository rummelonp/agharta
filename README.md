# Agharta

[![Build Status](https://travis-ci.org/mitukiii/agharta.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/mitukiii/agharta.png?travis)][gemnasium]

[travis]: https://travis-ci.org/mitukiii/agharta
[gemnasium]: https://gemnasium.com/mitukiii/agharta

Twitter Streaming API aggregator.

## Installation

```sh
gem install agharta
```

## Usage

```sh
agharta execute example/stream.rb # execute stream recipe example
agharta cat example/stream.rb     # show stream recipe example
agharta user:add                  # add new twitter account to configuration
agharta user:default              # change default twitter account
agharta user:list                 # show twitter account list
agharta edit stream.rb            # edit new your stream recipe
agharta cat stream.rb             # show your stream recipe
agharta execute stream.rb         # execute your stream recipe
agharta console                   # start recipe context console
```

Your can write recipe in `$HOME/.agharta/recipes`.

```ruby
stream {
  # account configuration
  credentials :mitukiii

  # account configuration
  # set :consumer_key, …
  # set :consumer_secret, …
  # set :oauth_token, …
  # set :oauth_token_secret, …

  # account configuration
  # set {
  #   :consumer_key => …,
  #   :consumer_secret => …,
  #   :oauth_token => …,
  #   :oauth_token_secret => …,
  # }

  # receive all replies
  replies_all
  # params[:replies] = :all

  # receive messages by followings
  with_followings
  # params[:with] = :followings

  # push & log keyword
  keyword {
    ignore_self!
    include 'mitukiii'
    exclude /^.*(RT|QT):? @[\w]+.*$/i
    notify :im_kayac
    log 'keyword.log'
  }

  # all tweets save to fluent
  user {
    all!
    store :fluentd, 'timeline', :host => 'localhost', :port => 24224
    log STDOUT
    log 'user.log'
  }

  # push & log @twitter tweets
  user(:twitter) {
    notify :im_kayac
    log 'twitter.log'
  }

  # push & log event
  event {
    on :reply, :retweet, :direct_message, :favorite, :follow, :list_member_added, :list_user_subscribed
    notify :im_kayac
    log 'event.log'
  }
}
```

You can also write.

```ruby
require 'agharta'

recipe = Agharta.new

recipe.stream {
  # do something...
}

recipe.execute
```

## Zsh Completion

You can use zsh completion.  
Put [_agharta][completion] file to zsh functions directory.

[completion]: https://github.com/mitukiii/agharta/blob/master/assets/completion/_agharta

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2013 [Kazuya Takeshima](mailto:mail@mitukiii.jp). See [LICENSE][license] for details.

[license]: LICENSE.md
