require "faraday"
require "oj"

module Scrapers
  class CardList
    def initialize(connection = nil)
      @connection = connection || new_connection
    end

    def results
      @results ||= Set.new
    end

    def scrape!
      page = fetch_page

      page["meta"]["pagination"]["total"]
      additional_pages = page["meta"]["pagination"]["pageCount"].to_i - 1

      extract_card_data(page["data"])

      additional_pages.times do |counter|
        page_number = counter + 2
        page = fetch_page(page_number)

        extract_card_data(page["data"])
      end
    end

    private

    def extract_card_data(data)
      data.each do |card_detail|
        results.add card_detail
      end
    end

    def fetch_page(page_number = 1)
      params = default_params.merge({
        pagination: {
          page: page_number,
          pageSize: 50
        }
      })

      response = @connection.get(path, params)
      Oj.load(response.body)
    end

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
              "$null" => true
            }
          }
        }
      }
    end
  end
end
