# frozen_string_literal: true

module WeatherGov
  class Product < Feature
    def issuing_office
      data.fetch("issuingOffice")
    end

    def issuance_time
      Time.parse(data.fetch("issuanceTime"))
    end

    def code
      data.fetch("productCode")
    end

    def name
      data.fetch("productName")
    end

    def text
      data.fetch("productText")
    end

    def product
      client.product(id: id) if id
    end
  end
end
