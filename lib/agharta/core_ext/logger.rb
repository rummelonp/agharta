# -*- coding: utf-8 -*-

require 'logger'

class Logger
  class SimpleFormatter < Formatter
    def call(severity, timestamp, progname, msg)
      msg = msg.is_a?(String) ? msg : msg.inspect
      "#{msg}\n"
    end
  end
end
