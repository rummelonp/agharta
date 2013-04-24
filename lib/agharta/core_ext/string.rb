# -*- coding: utf-8 -*-

require 'rainbow'

class String
  # @private
  COLORS = Sickill::Rainbow::TERM_COLORS.keys - [:default, :black, :white]

  # Return colorized string
  #
  # @return [String]
  def auto_color
    color(color_code)
  end

  # Return colorized string from pattern
  #
  # @param pattern [Regexp]
  # @param effects [Array<Symbol>]
  # @return [String]
  def colorize(pattern, *effects)
    split(/(#{pattern})/).map { |s|
      if s =~ /#{pattern}/
        s = effects.reduce(s.auto_color) { |s, effect| s.send(effect) }
      end
      s
    }.join('')
  end

  private
  def color_code
    COLORS[(each_byte.map(&:to_i).inject(&:+) || 0) % COLORS.size]
  end
end
