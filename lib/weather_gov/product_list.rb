# frozen_string_literal: true

require "weather_gov/feature"
require "weather_gov/product"
require "forwardable"

module WeatherGov
  class ProductList < Feature
    extend Forwardable

    def items
      @items ||= data.fetch("@graph").map { |item| Product.new(client: client, data: item) }
    end

    def_delegators :items, :[], :size, :each, :first, :last, :map
  end
end
