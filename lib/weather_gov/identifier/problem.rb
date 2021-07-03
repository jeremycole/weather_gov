# frozen_string_literal: true

require "weather_gov/identifier"

module WeatherGov
  class Identifier
    class Problem < Identifier
      def self.base_uri
        URI.join(super, "/problems/").to_s
      end
    end
  end
end
