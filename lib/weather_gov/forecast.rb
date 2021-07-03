# frozen_string_literal: true

require "weather_gov/forecast_period"

module WeatherGov
  class Forecast < Feature
    def update_time
      @update_time ||= Time.parse(properties.fetch("updateTime"))
    end

    def valid_time
      @valid_time ||= ValidTime.parse(properties.fetch("validTimes"))
    end

    def valid?
      valid_time.valid?
    end

    def periods
      properties.fetch("periods").map { |period| ForecastPeriod.new(data: period) }
    end

    def current
      periods.find { |p| (p.start_time...p.end_time).include?(Time.now) }
    end
  end
end
