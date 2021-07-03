# frozen_string_literal: true

require "weather_gov/identifier"

module WeatherGov
  class Identifier
    class Office < Identifier
      def self.base_uri
        URI.join(super, "/offices/").to_s
      end
    end
  end
end
