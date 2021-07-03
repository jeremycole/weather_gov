# frozen_string_literal: true

require "weather_gov/feature"
require "weather_gov/relative_location"

module WeatherGov
  class Point < Feature
    def forecast_office_identifier
      @forecast_office_identifier ||= Identifier::Office.new(properties.fetch("forecastOffice"))
    end

    def forecast_office
      @forecast_office ||= client.office(uri: forecast_office_identifier.uri)
    end

    def forecast_zone_identifier
      @forecast_zone_identifier ||= Identifier::ForecastZone.new(properties.fetch("forecastZone"))
    end

    def forecast_zone
      @forecast_zone ||= client.zone(uri: forecast_zone_identifier.uri)
    end

    def county_zone_identifier
      @county_zone_identifier ||= Identifier::CountyZone.new(properties.fetch("county"))
    end

    def county_zone
      @county_zone ||= client.zone(uri: county_zone_identifier.uri)
    end

    def fire_zone_identifier
      @fire_zone_identifier ||= Identifier::FireZone.new(properties.fetch("fireWeatherZone"))
    end

    def fire_zone
      @fire_zone ||= client.zone(uri: fire_zone_identifier.uri)
    end

    def forecast_grid_data
      @forecast_grid_data ||= Identifier::Gridpoint.new(properties.fetch("forecastGridData"))
    end

    def relative_location
      @relative_location ||= RelativeLocation.new(client: client, data: properties.fetch("relativeLocation"))
    end

    def radar_station
      properties.fetch("radarStation")
    end

    def observation_stations
      @observation_stations ||= client.stations(uri: properties.fetch("observationStations"))
    end

    def alerts_active
      @alerts_active ||= client.alerts_active(zone: forecast_zone_identifier.id)
    end

    def gridpoint
      @gridpoint ||= client.gridpoint(uri: properties.fetch("forecastGridData"))
    end

    def forecast
      @forecast ||= client.forecast(uri: properties.fetch("forecast"))
    end

    def forecast_hourly
      @forecast_hourly ||= client.forecast(uri: properties.fetch("forecastHourly"))
    end

    def products(type)
      @products ||= {}
      @products[type] ||= client.products(type: type, location: forecast_office_identifier.id)
    end

    def product(type)
      products(type).first.product
    end
  end
end
