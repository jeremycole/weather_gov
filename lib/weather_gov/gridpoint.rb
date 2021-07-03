# frozen_string_literal: true

require "weather_gov/valid_duration_value"

module WeatherGov
  class Gridpoint < Feature
    def update_time
      @update_time ||= Time.parse(properties.fetch("updateTime"))
    end

    def forecast_office
      @forecast_office ||= Identifier::Office.new(properties.fetch("forecastOffice"))
    end

    def temperature_unit
      @temperature_unit ||= properties.dig("temperature", "uom").split(":").last
    end

    def temperature
      @temperature ||= properties.dig("temperature", "values").map do |data|
        ValidDurationValue.new(data: data, unit: temperature_unit)
      end
    end

    def dewpoint_unit
      @dewpoint_unit ||= properties.dig("dewpoint", "uom").split(":").last
    end

    def dewpoint
      @dewpoint ||= properties.dig("dewpoint", "values").map do |data|
        ValidDurationValue.new(data: data, unit: dewpoint_unit)
      end
    end

    def min_temperature_unit
      @min_temperature_unit ||= properties.dig("minTemperature", "uom").split(":").last
    end

    def min_temperature
      @min_temperature ||= properties.dig("minTemperature", "values").map do |data|
        ValidDurationValue.new(data: data, unit: min_temperature_unit)
      end
    end

    def max_temperature_unit
      @max_temperature_unit ||= properties.dig("maxTemperature", "uom").split(":").last
    end

    def max_temperature
      @max_temperature ||= properties.dig("maxTemperature", "values").map do |data|
        ValidDurationValue.new(data: data, unit: max_temperature_unit)
      end
    end

    def apparent_temperature_unit
      @apparent_temperature_unit ||= properties.dig("apparentTemperature", "uom").split(":").last
    end

    def apparent_temperature
      @apparent_temperature ||= properties.dig("apparentTemperature", "values").map do |data|
        ValidDurationValue.new(data: data, unit: apparent_temperature_unit)
      end
    end

    def relative_humidity_unit
      @relative_humidity_unit ||= properties.dig("relativeHumidity", "uom").split(":").last
    end

    def relative_humidity
      @relative_humidity ||= properties.dig("relativeHumidity", "values").map do |data|
        ValidDurationValue.new(data: data, unit: relative_humidity_unit)
      end
    end
  end
end
