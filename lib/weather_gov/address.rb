# frozen_string_literal: true

module WeatherGov
  class Address
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def street_address
      data.fetch("streetAddress")
    end

    def address_locality
      data.fetch("addressLocality")
    end

    def address_region
      data.fetch("addressRegion")
    end

    def postal_code
      data.fetch("postalCode")
    end
  end
end
