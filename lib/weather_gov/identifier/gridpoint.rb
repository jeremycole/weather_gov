# frozen_string_literal: true

require "weather_gov/identifier"

module WeatherGov
  class Identifier
    class Gridpoint < Identifier
      def self.base_uri
        URI.join(super, "/gridpoints/").to_s
      end

      def office_id
        @office_id ||= id.split("/")[0]
      end

      def grid_id
        @grid_id ||= id.split("/")[1]
      end

      def grid_x
        @grid_x ||= grid_id.split(",")[0]
      end

      def grid_y
        @grid_y ||= grid_id.split(",")[1]
      end
    end
  end
end
