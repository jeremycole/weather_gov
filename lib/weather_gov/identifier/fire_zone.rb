# frozen_string_literal: true

require "weather_gov/identifier"

module WeatherGov
  class Identifier
    class FireZone < Identifier
      def self.base_uri
        URI.join(super, "/zones/fire/").to_s
      end
    end
  end
end
