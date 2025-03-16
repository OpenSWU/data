require "spec_helper"

require "exporters/csv/cards"

RSpec.describe Exporters::CSV::Cards do
  subject(:exporter) { Exporters::CSV::Cards.new(cache_dir, export_dir) }
  let(:cache_dir) { "spec/fixtures/cache/" }
  let(:export_dir) { "tmp/tests/exports" }
  let(:csv_path) { File.join(export_dir, "cards.csv") }

  after do
    FileUtils.rm_rf(export_dir) if Dir.exist?(export_dir)
  end

  describe "#export!" do
    it "creates an cards.csv file in the specified export location" do
      expect { exporter.export! }.to change {
        File.exist?(export_dir + "/cards.csv")
      }.from(false).to(true)
    end

    context "when the export directory already exists" do
      before do
        FileUtils.mkdir_p(export_dir)
      end

      it "exports as expected" do
        expect { exporter.export! }.to change {
          File.exist?(export_dir + "/cards.csv")
        }.from(false).to(true)
      end
    end

    describe "the exporterd cards.csv file" do
      let(:headers) { CSV.open(csv_path, &:readline) }
      let(:table) { CSV.read(csv_path, headers: true) }

      before do
        exporter.export!
      end

      it "has the correct headers" do
        expect(headers).to eq %w[id swu_card_id title subtitle card_number locale artist expansion_id front_art_url
          front_art_is_horizontal back_art_url back_art_is_horizontal has_foil is_hyperspace is_showcase play_cost
          base_hp base_power unique upgrade_hp upgrade_power rarity_id front_type_id back_type_id aspect_ids arena_ids
          trait_ids keyword_ids]
      end

      it "contains the expected records" do
        expected_row = ["e18d7a0f-7b86-5dca-88ed-ba9c89b8b60b", "0011262813", "Wedge Antilles", "Leader of Red Squadron",
          "8", "en", "David Buisan", "b026ab8b-a973-5327-adaf-75353683a9a6",
          "https://cdn.starwarsunlimited.com//04010008_EN_Wedge_Antilles_Leader_1f73212484.png", "true",
          "https://cdn.starwarsunlimited.com//04010008_EN_Wedge_Antilles_Leader_Unit_6414788e89.png", "false", "true",
          "false", "false", "5", "6", "3", "true", "4", "3", "44ce121b-97a1-56f9-8df4-3e6fa003c7a0",
          "3c5da669-cd53-548a-ab3c-2db0483f6c38", "be6c5e23-8df3-5720-bb58-76de7be747b6",
          "dcdb0597-ecf8-5f45-9595-72f9f3660e6a;40ffce8a-e036-52a9-b497-0c1c484a8a06",
          "01bb6d4b-3455-5dc1-a62e-855d6e4465d1",
          "dc9f18f3-72c8-5622-b91c-8a95823f505b;b4f4b731-c6bf-5ad3-bffa-a38143874127",
          "7d84ab0a-b29d-50b0-8520-0b68d9afffb6"]

        expect(table.size).to eq 3
        expect(table[0]).to eq CSV::Row.new(headers, expected_row)
      end
    end
  end
end
