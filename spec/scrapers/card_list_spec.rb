require "spec_helper"
require "fileutils"
require "scrapers/card_list"

RSpec.describe Scrapers::CardList do
  subject(:scraper) { described_class.new(connection: connection, cache_dir: cache_dir) }
  let!(:cache_dir) { Dir.mktmpdir }
  let(:results) { scraper.results }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new(strict_mode: true) }
  let(:connection) { Faraday.new { |b| b.adapter(:test, stubs) } }

  it "sets up a new connection to the SWU API" do
    expect(Faraday).to receive(:new).with("https://admin.starwarsunlimited.com")
    described_class.new
  end

  before do
    stubs.get("/api/card-list?locale=en&pagination[page]=1&pagination[pageSize]=50") do |env|
      [
        200,
        {"Content-Type": "application/javascript"},
        File.read("spec/fixtures/card_list_page_1.json")
      ]
    end

    stubs.get("/api/card-list?locale=en&pagination[page]=2&pagination[pageSize]=50") do |_env|
      [
        200,
        {"Content-Type": "application/javascript"},
        File.read("spec/fixtures/card_list_page_2.json")
      ]
    end
  end

  after do
    Faraday.default_connection = nil
    FileUtils.remove_entry(cache_dir)
  end

  describe "#scrape!" do
    it "writes card details to individual JSON files" do
      expect {
        scraper.scrape!
      }.to change {
        Dir["#{cache_dir}/openswu-data/*.json"].length
      }.from(0).to(100)

      stubs.verify_stubbed_calls
    end
  end
end
