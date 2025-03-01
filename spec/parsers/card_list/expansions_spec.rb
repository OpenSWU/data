# frozen_string_literal: true

require "spec_helper"

require "parsers/card_list/expansions"

RSpec.describe Parsers::CardList::Expansions do
  subject(:parser) { described_class.new }
  let(:cache_dir) { "spec/fixtures/cache/" }

  it { is_expected.to be_an Enumerable }

  describe ".load_cache" do
    subject(:parser) { described_class.load_cache cache_dir }

    it { is_expected.to be_a Parsers::CardList::Expansions }
    its(:size) { is_expected.to eq 3 }
    its(:count) { is_expected.to eq 3 }
  end

  describe "#load_cache" do
    it "populates the size attribute" do
      expect {
        parser.load_cache cache_dir
      }.to change { parser.size }.from(0).to(3)
    end
  end

  describe "#each" do
    subject(:parser) { described_class.load_cache cache_dir }

    it "returns each card as a Expansion" do
      expect(parser).to all(be_a Expansion)
    end
  end
end
