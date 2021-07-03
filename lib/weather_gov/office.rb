# frozen_string_literal: true

require "weather_gov/feature"
require "weather_gov/address"

module WeatherGov
  class Office < Feature
    def name
      data.fetch("name")
    end

    def address
      @address ||= Address.new(data.fetch("address"))
    end

    def telephone
      data.fetch("telephone")
    end

    def fax
      data.fetch("faxNumber")
    end

    def email
      data.fetch("email")
    end

    def nws_region
      data.fetch("nwsRegion")
    end

    def parent_organization
      data.fetch("parentOrganization")
    end

    def responsible_counties
      data.fetch("responsibleCounties", [])
    end

    def responsible_county_ids
      data.fetch("responsibleCounties", []).map { |uri| Identifier::CountyZone.new(uri).id }
    end

    def responsible_forecast_zones
      data.fetch("responsibleForecastZones", [])
    end

    def responsible_forecast_zone_ids
      data.fetch("responsibleForecastZones", []).map { |uri| Identifier::ForecastZone.new(uri).id }
    end

    def responsible_fire_zones
      data.fetch("responsibleFireZones", [])
    end

    def responsible_fire_zone_ids
      data.fetch("responsibleFireZones", []).map { |uri| Identifier::FireZone.new(uri).id }
    end

    def approved_observation_stations
      data.fetch("approvedObservationStations", []).map { |uri| client.station(uri: uri, value: uri) }
    end

    def approved_observation_station_ids
      data.fetch("approvedObservationStations", []).map { |uri| Identifier::Station.new(uri).id }
    end
  end
end
