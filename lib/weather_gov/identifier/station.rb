# frozen_string_literal: true

require "weather_gov/identifier"

module WeatherGov
  class Identifier
    class Station < Identifier
      def self.base_uri
        URI.join(super, "/stations/").to_s
      end
    end
  end
end
