# frozen_string_literal: true

require "weather_gov/office"
require "weather_gov/observation_station"
require "weather_gov/observation_station_collection"
require "weather_gov/point"
require "weather_gov/gridpoint"
require "weather_gov/alert_collection"
require "weather_gov/forecast"
require "weather_gov/zone"
require "weather_gov/product"
require "weather_gov/product_list"

module WeatherGov
  class Client
    attr_reader :api

    def initialize(user_agent:)
      @api = API.new(user_agent: user_agent)
    end

    def json_for(response)
      return response.parsed_response unless response.parsed_response.include?("status")

      raise response.parsed_response.fetch("title", "Unknown Error")
    end

    def stations(data: nil, uri: nil)
      return ObservationStationCollection.new(client: self, data: data) if data
      return ObservationStationCollection.new(client: self, data: -> { json_for(api.get(uri: uri)) }) if uri

      # In theory an "all stations" query is okay, but in practice it seems to time out.

      raise ArgumentError, "data or uri parameter required"
    end

    def station(data: nil, uri: nil, id: nil)
      return ObservationStation.new(client: self, data: data) if data
      return ObservationStation.new(client: self, data: -> { json_for(api.get(uri: uri)) }) if uri
      return ObservationStation.new(client: self, data: -> { json_for(api.station(id: id)) }) if id

      raise ArgumentError, "data or id parameter required"
    end

    def office(data: nil, uri: nil, id: nil)
      return Office.new(client: self, data: data) if data
      return Office.new(client: self, data: -> { json_for(api.get(uri: uri)) }) if uri
      return Office.new(client: self, data: -> { json_for(api.office(id: id)) }) if id

      raise ArgumentError, "data, uri, or id parameter required"
    end

    def point(data: nil, uri: nil, lat: nil, lon: nil)
      return Point.new(client: self, data: data) if data
      return Point.new(client: self, data: -> { json_for(api.get(uri: uri)) }) if uri
      return Point.new(client: self, data: -> { json_for(api.point(lat: lat, lon: lon)) }) if lat && lon

      raise ArgumentError, "data, uri, or lat and lon parameters required"
    end

    def gridpoint(data: nil, uri: nil)
      return Gridpoint.new(client: self, data: data) if data
      return Gridpoint.new(client: self, data: -> { json_for(api.get(uri: uri)) }) if uri

      raise ArgumentError, "data, uri, or lat and lon parameters required"
    end

    def alerts_active(data: nil, zone: nil, area: nil, region: nil)
      return AlertCollection.new(client: self, data: data) if data

      if zone || area || region
        return AlertCollection.new(
          client: self,
          data: -> { json_for(api.alerts_active(zone: zone, area: area, region: region)) }
        )
      end

      raise ArgumentError, "data, zone, area, or region parameter required"
    end

    def zone(data: nil, uri: nil, type: nil, id: nil)
      return Zone.new(client: self, data: data) if data
      return Zone.new(client: self, data: -> { json_for(api.get(uri: uri)) }) if uri
      return Zone.new(client: self, data: -> { json_for(api.zone(type: type, id: id)) }) if type && id

      raise ArgumentError, "data, uri, or type and id parameter required"
    end

    def forecast(data: nil, uri: nil)
      return Forecast.new(client: self, data: data) if data
      return Forecast.new(client: self, data: -> { json_for(api.get(uri: uri)) }) if uri

      raise ArgumentError, "data or uri parameter required"
    end

    def products(data: nil, uri: nil, type: nil, location: nil)
      return ProductList.new(client: self, data: data) if data
      return ProductList.new(client: self, data: -> { json_for(api.get(uri: uri)) }) if uri

      if type && location
        return ProductList.new(client: self, data: -> { json_for(api.products(type: type, location: location)) })
      end

      raise ArgumentError, "data, uri, or type and location parameters required"
    end

    def product(data: nil, uri: nil, id: nil)
      return Product.new(client: self, data: data) if data
      return Product.new(client: self, data: -> { json_for(api.get(uri: uri)) }) if uri
      return Product.new(client: self, data: -> { json_for(api.product(id: id)) }) if id

      raise ArgumentError, "data, uri, or id parameter required"
    end
  end
end
