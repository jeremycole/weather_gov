# frozen_string_literal: true

require "weather_gov/identifier"

module WeatherGov
  class Identifier
    class Alert < Identifier
      def self.base_uri
        URI.join(super, "/alerts/").to_s
      end
    end
  end
end
