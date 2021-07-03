# frozen_string_literal: true

require "weather_gov/identifier"

module WeatherGov
  class Identifier
    class Point < Identifier
      def self.base_uri
        URI.join(super, "/points/").to_s
      end

      def lat
        @lat ||= id.split(",")[0]
      end

      def lon
        @lon ||= id.split(",")[1]
      end
    end
  end
end
