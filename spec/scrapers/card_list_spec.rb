require "spec_helper"
require "scrapers/card_list"

RSpec.describe Scrapers::CardList do
  subject(:scraper) { described_class.new(connection) }
  let(:result) { scraper.scrape }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:connection) { Faraday.new { |b| b.adapter(:test, stubs) } }

  before do
    stubs.get("/api/card-list") do |env|
      expect(env.params).to eq({
        "locale" => "en",
        "filters" => {
          "variantOf" => {
            "id" => {
              "$null" => "true"
            }
          }
        },
        "pagination" => {
          "page" => "1",
          "pageSize" => "50"
        }
      })

      [
        200,
        {"Content-Type": "application/javascript"},
        File.read("spec/fixtures/card_list_page_1.json")
      ]
    end
  end

  describe "#scrape" do
    it "fetches /api/card-list with expected parameters" do
      scraper.scrape
      stubs.verify_stubbed_calls
    end

    it "returns an enumerator of cards" do
      expect(result).to be_an(Enumerator).and all(be_a(Hash))
    end
  end
end
