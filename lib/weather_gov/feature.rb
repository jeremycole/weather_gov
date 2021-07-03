# frozen_string_literal: true

module WeatherGov
  class Feature
    attr_reader :client

    def initialize(client:, data:)
      @client = client
      if data.respond_to?(:call)
        @data_proc = data
      else
        @data = data
      end
    end

    def data
      @data ||= @data_proc.call
    end

    def context
      data.fetch("@context", nil)
    end

    def id
      data.fetch("id")
    end

    def type
      data.fetch("type")
    end

    def geometry
      data.fetch("geometry", nil)
    end

    def properties
      data.fetch("properties", nil)
    end
  end
end
