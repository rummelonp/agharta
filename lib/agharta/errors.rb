# -*- coding: utf-8 -*-

module Agharta
  # Custom error class for rescuing from all Agharta errors
  class AghartaError < StandardError
  end

  # Raised when configuration is not enough
  class ConfigurationError < AghartaError
  end

  # Raised when a some API returns the error
  class APIError < AghartaError
  end
end
