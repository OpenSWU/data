require "spec_helper"

require "exporters/csv/rarities"

RSpec.describe Exporters::CSV::Rarities do
  subject(:exporter) { Exporters::CSV::Rarities.new(cache_dir, export_dir) }
  let(:cache_dir) { "spec/fixtures/cache/" }
  let(:export_dir) { "tmp/tests/exports" }
  let(:csv_path) { File.join(export_dir, "rarities.csv") }

  after do
    FileUtils.rm_rf(export_dir) if Dir.exist?(export_dir)
  end

  describe "#export!" do
    it "creates an rarities.csv file in the specified export location" do
      expect { exporter.export! }.to change {
        File.exist?(export_dir + "/rarities.csv")
      }.from(false).to(true)
    end

    context "when the export directory already exists" do
      before do
        FileUtils.mkdir_p(export_dir)
      end

      it "exports as expected" do
        expect { exporter.export! }.to change {
          File.exist?(export_dir + "/rarities.csv")
        }.from(false).to(true)
      end
    end

    describe "the exporterd rarities.csv file" do
      let(:headers) { CSV.open(csv_path, &:readline) }
      let(:table) { CSV.read(csv_path, headers: true) }

      before do
        exporter.export!
      end

      it "has the correct headers" do
        expect(headers).to eq %w[id name character color locale english_name]
      end

      it "contains the expected records" do
        expected_row = ["44ce121b-97a1-56f9-8df4-3e6fa003c7a0", "Common", "C", "#964d02", "en", "Common"]
        expect(table.size).to eq 1
        expect(table[0]).to eq CSV::Row.new(headers, expected_row)
      end
    end
  end
end
