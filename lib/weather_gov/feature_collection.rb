# frozen_string_literal: true

require "weather_gov/feature"
require "forwardable"

module WeatherGov
  class FeatureCollection < Feature
    extend Forwardable

    def self.feature_class
      Feature
    end

    def features
      @features ||= data.fetch("features").map { |feature| self.class.feature_class.new(client: client, data: feature) }
    end

    def_delegators :features, :[], :size, :each, :first, :last, :map
  end
end
