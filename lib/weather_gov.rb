# frozen_string_literal: true

require "weather_gov/version"

module WeatherGov
  class Error < StandardError; end

  API_BASE_URI = "https://api.weather.gov"
end

require "weather_gov/identifier"
require "weather_gov/api"
require "weather_gov/client"
