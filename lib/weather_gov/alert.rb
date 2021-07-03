# frozen_string_literal: true

module WeatherGov
  class Alert < Feature
    SUMMARY_KEYS = [
      "sent",
      "effective",
      "onset",
      "expires",
      "ends",
      "status",
      "severity",
      "certainty",
      "urgency",
      "event",
      "headline",
      "description",
      "instruction",
    ].freeze

    def sent_time
      Time.parse(properties.fetch("sent"))
    end

    def effective_time
      Time.parse(properties.fetch("effective"))
    end

    def expires_time
      Time.parse(properties.fetch("expires"))
    end

    def active_time_range
      effective_time...expires_time
    end

    def active?
      active_time_range.include?(Time.now)
    end

    def summary_hash
      properties.slice(*SUMMARY_KEYS)
    end
  end
end
