# frozen_string_literal: true

require "weather_gov/feature_collection"
require "weather_gov/alert"

module WeatherGov
  class AlertCollection < FeatureCollection
    def self.feature_class
      Alert
    end

    def update_time
      @update_time ||= Time.parse(data.fetch("updated"))
    end

    def title
      data.fetch("title")
    end

    def alerts
      features
    end

    def summary
      features.map(&:summary_hash)
    end
  end
end
