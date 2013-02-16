# -*- coding: utf-8 -*-

module Agharta
  module Executable
    def executables
      @executables ||= []
    end

    def executable(executable)
      executables << executable
      executable
    end

    def execute
      raise NotImplementedError
    end
  end
end
