require "spec_helper"

require "exporters/aspects"

RSpec.describe Exporters::Aspects do
  subject(:exporter) { Exporters::Aspects.new(cache_dir, export_dir) }
  let(:cache_dir) { "spec/fixtures/cache/" }
  let(:export_dir) { "tmp/tests/exports" }
  let(:csv_path) { File.join(export_dir, "aspects.csv") }

  after do
    FileUtils.rm_rf(export_dir) if Dir.exist?(export_dir)
  end

  describe "#export!" do
    it "creates an aspects.csv file in the specified export location" do
      expect { exporter.export! }.to change {
        File.exist?(export_dir + "/aspects.csv")
      }.from(false).to(true)
    end

    context "when the export directory already exists" do
      before do
        FileUtils.mkdir_p(export_dir)
      end

      it "exports as expected" do
        expect { exporter.export! }.to change {
          File.exist?(export_dir + "/aspects.csv")
        }.from(false).to(true)
      end
    end

    describe "the exporterd aspects.csv file" do
      let(:headers) { CSV.open(csv_path, &:readline) }
      let(:table) { CSV.read(csv_path, headers: true) }

      before do
        exporter.export!
      end

      it "has the correct headers" do
        expect(headers).to eq %w[id name description color locale english_name]
      end

      it "contains the expected records" do
        expected_row = ["dcdb0597-ecf8-5f45-9595-72f9f3660e6a", "Command", a_string_including("Accelerate your resources"), "#0b992d", "en", "Command"]
        expect(table.size).to eq 3
        expect(table.to_a).to include expected_row
      end
    end
  end
end
