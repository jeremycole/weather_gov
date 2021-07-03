# frozen_string_literal: true

require "weather_gov/valid_time"

module WeatherGov
  class ValidDurationValue
    attr_reader :data, :unit

    def initialize(data:, unit: nil)
      @data = data
      @unit = unit
    end

    def valid_time
      @valid_time ||= ValidTime.new(data.fetch("validTime"))
    end

    def valid?
      valid_time.valid?
    end

    def value
      @value ||= data.fetch("value")
    end
  end
end
