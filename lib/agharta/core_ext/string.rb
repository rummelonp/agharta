# -*- coding: utf-8 -*-

require 'rainbow'

class String
  COLORS = Sickill::Rainbow::TERM_COLORS.keys - [:default, :black, :white]

  def color_code
    COLORS[(each_byte.map(&:to_i).inject(&:+) || 0) % COLORS.size]
  end

  def auto_color
    color(color_code)
  end

  def colorize(pattern, *effects)
    split(/(#{pattern})/).map { |s|
      if s =~ /#{pattern}/
        s = effects.reduce(s.auto_color) { |s, effect| s.send(effect) }
      end
      s
    }.join('')
  end
end
