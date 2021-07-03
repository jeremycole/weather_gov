# frozen_string_literal: true

require "weather_gov/feature_collection"
require "weather_gov/observation_station"

module WeatherGov
  class ObservationStationCollection < FeatureCollection
    def self.feature_class
      ObservationStation
    end

    def update_time
      @update_time ||= Time.parse(data.fetch("updated"))
    end

    def observation_stations
      data.fetch("observationStations")
    end
  end
end
