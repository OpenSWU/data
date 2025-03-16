require "spec_helper"

require "exporters/csv/expansions"

RSpec.describe Exporters::CSV::Expansions do
  subject(:exporter) { Exporters::CSV::Expansions.new(cache_dir, export_dir) }
  let(:cache_dir) { "spec/fixtures/cache/" }
  let(:export_dir) { "tmp/tests/exports" }
  let(:csv_path) { File.join(export_dir, "expansions.csv") }

  after do
    FileUtils.rm_rf(export_dir) if Dir.exist?(export_dir)
  end

  describe "#export!" do
    it "creates an expansions.csv file in the specified export location" do
      expect { exporter.export! }.to change {
        File.exist?(export_dir + "/expansions.csv")
      }.from(false).to(true)
    end

    context "when the export directory already exists" do
      before do
        FileUtils.mkdir_p(export_dir)
      end

      it "exports as expected" do
        expect { exporter.export! }.to change {
          File.exist?(export_dir + "/expansions.csv")
        }.from(false).to(true)
      end
    end

    describe "the exporterd expansions.csv file" do
      let(:headers) { CSV.open(csv_path, &:readline) }
      let(:table) { CSV.read(csv_path, headers: true) }

      before do
        exporter.export!
      end

      it "has the correct headers" do
        expect(headers).to eq %w[id code name description locale card_count]
      end

      it "contains the expected records" do
        expected_row = ["b026ab8b-a973-5327-adaf-75353683a9a6", "JTL", "Jump to Lightspeed", "", "en", "257"]
        expect(table.size).to eq 3
        expect(table.to_a).to include expected_row
      end
    end
  end
end
