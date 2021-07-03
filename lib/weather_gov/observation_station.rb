# frozen_string_literal: true

require "weather_gov/feature"

module WeatherGov
  class ObservationStation < Feature
    def forecast_zone
      @forecast_zone ||= Identifier::ForecastZone.new(properties.fetch("forecast"))
    end

    def fire_weather_zone
      @fire_weather_zone ||= Identifier::FireZone.new(properties.fetch("fireWeatherZone"))
    end

    def station_identifier
      properties.fetch("stationIdentifier")
    end

    def name
      properties.fetch("name")
    end

    def elevation
      properties.fetch("elevation")
    end
  end
end
