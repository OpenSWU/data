require "faraday"
require "oj"
require "progress_bar"
require "tmpdir"

module Scrapers
  class CardList
    def initialize(connection: nil, cache_dir: Dir.mktmpdir)
      @connection = connection || new_connection
      @cache_dir = cache_dir
      set_up_cache
    end

    def scrape!
      page = fetch_page

      page["meta"]["pagination"]["total"]
      additional_pages = page["meta"]["pagination"]["pageCount"].to_i - 1
      progress = ProgressBar.new(additional_pages)

      extract_card_data(page["data"])

      additional_pages.times do |counter|
        page_number = counter + 2
        page = fetch_page(page_number)

        extract_card_data(page["data"])
        progress.increment!
      end
    end

    private

    def cache_to_disk!(result)
      filename = result["attributes"]["cardUid"] || result["attributes"]["cardId"]
      File.write("#{@cache_dir}/openswu-data/#{filename}.json", result.to_json)
    end

    def default_params
      {
        locale: "en"
      }
    end

    def extract_card_data(data)
      data.each do |card_detail|
        cache_to_disk! card_detail
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

    def set_up_cache
      Dir.exist?("#{@cache_dir}/openswu-data") or
        Dir.mkdir("#{@cache_dir}/openswu-data")
    end
  end
end
