require "spec_helper"

require "exporters/base"

class TestExporter < Exporters::Base
  # No-Op to prevent failing on default behavior.
  def initialize(*args)
  end
end

RSpec.describe Exporters::Base do
  subject(:exporter) { TestExporter.new("", "") }

  it "raises and error if parser_klass method is undefined" do
    expect { exporter.send(:parser_klass) }.to raise_error(NoMethodError, "define `parser_klass` for TestExporter")
  end

  it "raises and error if export_filename method is undefined" do
    expect { exporter.send(:export_filename) }.to raise_error(NoMethodError, "define `export_filename` for TestExporter")
  end
end
