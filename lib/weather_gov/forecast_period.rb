# frozen_string_literal: true

module WeatherGov
  class ForecastPeriod
    attr_reader :data

    def initialize(data:)
      @data = data
    end

    def number
      data.fetch("number")
    end

    def name
      data.fetch("name")
    end

    def start_time
      @start_time ||= Time.parse(data.fetch("startTime"))
    end

    def end_time
      @end_time ||= Time.parse(data.fetch("endTime"))
    end

    def daytime?
      data.fetch("isDaytime")
    end

    def temperature
      data.fetch("temperature")
    end

    def temperature_unit
      data.fetch("temperatureUnit")
    end

    def temperature_trend
      data.fetch("temperatureTrend")
    end

    def wind_speed
      data.fetch("windSpeed")
    end

    def wind_direction
      data.fetch("windDirection")
    end

    def icon
      data.fetch("icon")
    end

    def short_forecast
      data.fetch("shortForecast")
    end

    def detailed_forecast
      data.fetch("detailedForecast")
    end
  end
end
