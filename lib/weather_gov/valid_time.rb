# frozen_string_literal: true

require "active_support/time"
require "active_support/duration"

module WeatherGov
  class ValidTime
    def self.parse(valid_time_string)
      ValidTime.new(valid_time_string)
    end

    def initialize(valid_time_string)
      @valid_time_string = valid_time_string
    end

    def fields
      @fields ||= @valid_time_string.split("/")
    end

    def start_time
      @start_time ||= Time.parse(fields.first)
    end

    def duration
      @duration ||= ActiveSupport::Duration.parse(fields.last)
    end

    def end_time
      start_time + duration
    end

    def range
      start_time...end_time
    end

    def valid?(time = Time.now)
      range.include?(time)
    end

    def elapsed(time = Time.now)
      ActiveSupport::Duration.build(time - start_time)
    end

    def remaining(time = Time.now)
      ActiveSupport::Duration.build(end_time - time)
    end
  end
end
