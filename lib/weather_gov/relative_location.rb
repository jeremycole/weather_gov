# frozen_string_literal: true

require "weather_gov/feature"

module WeatherGov
  class RelativeLocation < Feature
    def city
      properties.fetch("city")
    end

    def state
      properties.fetch("state")
    end

    def distance
      properties.fetch("distance")
    end

    def bearing
      properties.fetch("bearing")
    end
  end
end
