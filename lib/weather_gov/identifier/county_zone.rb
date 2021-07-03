# frozen_string_literal: true

require "weather_gov/identifier"

module WeatherGov
  class Identifier
    class CountyZone < Identifier
      def self.base_uri
        URI.join(super, "/zones/county/").to_s
      end
    end
  end
end
