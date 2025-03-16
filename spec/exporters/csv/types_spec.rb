require "spec_helper"

require "exporters/csv/types"

RSpec.describe Exporters::CSV::Types do
  subject(:exporter) { Exporters::CSV::Types.new(cache_dir, export_dir) }
  let(:cache_dir) { "spec/fixtures/cache/" }
  let(:export_dir) { "tmp/tests/exports" }
  let(:csv_path) { File.join(export_dir, "types.csv") }

  after do
    FileUtils.rm_rf(export_dir) if Dir.exist?(export_dir)
  end

  describe "#export!" do
    it "creates an types.csv file in the specified export location" do
      expect { exporter.export! }.to change {
        File.exist?(export_dir + "/types.csv")
      }.from(false).to(true)
    end

    context "when the export directory already exists" do
      before do
        FileUtils.mkdir_p(export_dir)
      end

      it "exports as expected" do
        expect { exporter.export! }.to change {
          File.exist?(export_dir + "/types.csv")
        }.from(false).to(true)
      end
    end

    describe "the exporterd types.csv file" do
      let(:headers) { CSV.open(csv_path, &:readline) }
      let(:table) { CSV.read(csv_path, headers: true) }

      before do
        exporter.export!
      end

      it "has the correct headers" do
        expect(headers).to eq %w[id name description value locale]
      end

      it "contains the expected records" do
        expected_row = ["3c5da669-cd53-548a-ab3c-2db0483f6c38", "Leader", "", "Leader", "en"]
        expect(table.size).to eq 3
        expect(table[0]).to eq CSV::Row.new(headers, expected_row)
      end
    end
  end
end
