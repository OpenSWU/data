require "spec_helper"
require "scrapers/card_list"

RSpec.describe Scrapers::CardList do
  subject(:scraper) { described_class.new(connection) }
  let(:results) { scraper.results }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new(strict_mode: true) }
  let(:connection) { Faraday.new { |b| b.adapter(:test, stubs) } }

  before do
    stubs.get("/api/card-list?locale=en&filters[variantOf][id][$null]=true&pagination[page]=1&pagination[pageSize]=50") do |env|
      [
        200,
        {"Content-Type": "application/javascript"},
        File.read("spec/fixtures/card_list_page_1.json")
      ]
    end

    stubs.get("/api/card-list?locale=en&filters[variantOf][id][$null]=true&pagination[page]=2&pagination[pageSize]=50") do |_env|
      [
        200,
        {"Content-Type": "application/javascript"},
        File.read("spec/fixtures/card_list_page_2.json")
      ]
    end
  end

  after do
    Faraday.default_connection = nil
  end

  describe "#scrape!" do
    it "populates #results with card details" do
      expect {
        scraper.scrape!
      }.to change {
        scraper.results.size
      }.from(0).to(100)

      expect(results).to be_a(Set).and(all(be_a Hash))
      expect(results).to include(hash_including({"id" => 5, "attributes" => hash_including({"title" => "Luke Skywalker"})}))
      expect(results).to include(hash_including({"id" => 344, "attributes" => hash_including({"title" => "Colonel Yularen"})}))

      stubs.verify_stubbed_calls
    end
  end
end
