require "spec_helper"

require "exporters/traits"

RSpec.describe Exporters::Traits do
  subject(:exporter) { Exporters::Traits.new(cache_dir, export_dir) }
  let(:cache_dir) { "spec/fixtures/cache/" }
  let(:export_dir) { "tmp/tests/exports" }
  let(:csv_path) { File.join(export_dir, "traits.csv") }

  after do
    FileUtils.rm_rf(export_dir) if Dir.exist?(export_dir)
  end

  describe "#export!" do
    it "creates an traits.csv file in the specified export location" do
      expect { exporter.export! }.to change {
        File.exist?(export_dir + "/traits.csv")
      }.from(false).to(true)
    end

    context "when the export directory already exists" do
      before do
        FileUtils.mkdir_p(export_dir)
      end

      it "exports as expected" do
        expect { exporter.export! }.to change {
          File.exist?(export_dir + "/traits.csv")
        }.from(false).to(true)
      end
    end

    describe "the exporterd traits.csv file" do
      let(:headers) { CSV.open(csv_path, &:readline) }
      let(:table) { CSV.read(csv_path, headers: true) }

      before do
        exporter.export!
      end

      it "has the correct headers" do
        expect(headers).to eq %w[id name description locale]
      end

      it "contains the expected records" do
        expected_row = ["a7a43365-14d5-5923-be5d-487dc6ad500a", "Rebel", "", "en"]
        expect(table.size).to eq 5
        expect(table[0]).to eq CSV::Row.new(headers, expected_row)
      end
    end
  end
end
