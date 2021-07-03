# frozen_string_literal: true

require "httparty"

module WeatherGov
  class API
    class RequestError < RuntimeError; end

    include HTTParty
    base_uri API_BASE_URI
    format :json

    def initialize(user_agent:)
      @headers = {
        "User-Agent" => user_agent,
      }
    end

    def format_coord(value)
      format("%.2f", value).sub(/0+$/, "")
    end

    def format_coords(lat, lon)
      "#{format_coord(lat)},#{format_coord(lon)}"
    end

    def get(uri: nil, path: nil)
      response = self.class.get(uri || path)

      unless response.ok?
        if response.parsed_response
          error_type_id = Identifier::Problem.new(response.parsed_response.fetch("type")).id
          error_detail = response.parsed_response.fetch("detail", response.code)
          raise RequestError, "#{error_type_id}: #{error_detail}"
        end

        raise RequestError, "Error: Code #{response.code}"
      end

      response
    end

    def station(id:)
      get(path: "/stations/#{id}")
    end

    def office(id:)
      get(path: "/offices/#{id}")
    end

    def point(lat:, lon:)
      get(path: "/points/#{format_coords(lat, lon)}")
    end

    def gridpoint(office_id:, grid_x:, grid_y:)
      get(path: "/gridpoints/#{office_id}/#{grid_x},#{grid_y}")
    end

    def zone(type:, id:)
      get(path: "/zones/#{type}/#{id}")
    end

    def product_locations(type: nil)
      return get(path: "/products/types/#{type}/locations") if type

      get(path: "/products/locations")
    end

    def product_types(location: nil)
      return get(path: "/products/locations/#{location}/types") if location

      get(path: "/products/types")
    end

    def products(type: nil, location: nil)
      return get(path: "/products/types/#{type}/locations/#{location}") if type && location

      get(path: "/products")
    end

    def product(id:)
      get(path: "/products/#{id}")
    end

    def alerts_active(zone: nil, area: nil, region: nil)
      return get(path: "/alerts/active/zone/#{zone}") if zone
      return get(path: "/alerts/active/area/#{area}") if area
      return get(path: "/alerts/active/region/#{region}") if region

      get(path: "/alerts/active")
    end
  end
end
