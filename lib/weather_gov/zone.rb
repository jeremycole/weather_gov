# frozen_string_literal: true

module WeatherGov
  class Zone < Feature
    def type
      properties.fetch("type")
    end

    def name
      properties.fetch("name")
    end

    def state
      properties.fetch("state")
    end

    def effective_date
      Time.parse(properties.fetch("effectiveDate"))
    end

    def expiration
      Time.parse(properties.fetch("expirationDate"))
    end

    def forecast_office_identifiers
      properties.fetch("forecastOffices", []).map { |uri| Identifier::Office.new(uri) }
    end

    def forecast_offices
      forecast_office_identifiers.map { |identifier| client.office(uri: identifier.uri) }
    end
  end
end
