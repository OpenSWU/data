require "faraday"
require "oj"

module Scrapers
  class CardList
    def initialize(connection)
      @connection = connection || new_connection
    end

    def scrape
      response = @connection.get(path, default_params)
      Oj.load(response.body)
    end

    private

    def new_connection
      Faraday.new("https://admin.starwarsunlimited.com")
    end

    def path
      "/api/card-list"
    end

    def default_params
      {
        locale: "en",
        filters: {
          variantOf: {
            id: {
              "$null": true
            }
          }
        },
        pagination: {
          page: 1,
          pageSize: 50
        }
      }
    end
  end
end
