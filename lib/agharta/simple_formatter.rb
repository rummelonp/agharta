# -*- coding: utf-8 -*-

require 'logger'

module Agharta
  class SimpleFormatter < Logger::Formatter
    def call(severity, timestamp, progname, msg)
      msg = msg.is_a?(String) ? msg : msg.inspect
      "#{msg}\n"
    end
  end  
end
