# frozen_string_literal: true

module WeatherGov
  class Identifier
    attr_reader :uri

    def self.parse(uri)
      TYPES.each do |type|
        return type.new(uri) if uri.start_with?(type.base_uri)
      end

      nil
    end

    def self.base_uri
      API_BASE_URI
    end

    def initialize(uri)
      @uri = uri
    end

    def to_s
      id
    end

    def id
      uri.sub(/^#{self.class.base_uri}/, "")
    end
  end
end

require "weather_gov/identifier/alert"
require "weather_gov/identifier/county_zone"
require "weather_gov/identifier/fire_zone"
require "weather_gov/identifier/forecast_zone"
require "weather_gov/identifier/gridpoint"
require "weather_gov/identifier/office"
require "weather_gov/identifier/point"
require "weather_gov/identifier/problem"
require "weather_gov/identifier/station"

module WeatherGov
  class Identifier
    TYPES = constants.map { |c| const_get(c) }.select { |c| c.superclass == self }
  end
end
