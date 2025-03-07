require "spec_helper"

require "exporters/arenas"

RSpec.describe Exporters::Arenas do
  subject(:exporter) { Exporters::Arenas.new(cache_dir, export_dir) }
  let(:cache_dir) { "spec/fixtures/cache/" }
  let(:export_dir) { "tmp/tests/exports" }
  let(:csv_path) { File.join(export_dir, "arenas.csv") }

  after do
    FileUtils.rm_rf(export_dir) if Dir.exist?(export_dir)
  end

  describe "#export!" do
    it "creates an arenas.csv file in the specified export location" do
      expect { exporter.export! }.to change {
        File.exist?(export_dir + "/arenas.csv")
      }.from(false).to(true)
    end

    describe "the exporterd arenas.csv file" do
      let(:headers) { CSV.open(csv_path, &:readline) }
      let(:table) { CSV.read(csv_path, headers: true) }

      before do
        exporter.export!
      end

      it "has the correct headers" do
        expect(headers).to eq %w[id name description locale]
      end

      it "contains the expected records" do
        expected_row = ["01bb6d4b-3455-5dc1-a62e-855d6e4465d1", "Ground", nil, "en"]
        expect(table.size).to eq 1
        expect(table[0]).to eq CSV::Row.new(headers, expected_row)
      end
    end
  end
end
