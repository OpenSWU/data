require "spec_helper"
require "data"

RSpec.describe Aspect do
  subject(:card) { Aspect.new(*valid_attributes.values) }
  let(:valid_attributes) {
    {
      name: "Command",
      description: "<p>Accelerate your resources ...",
      color: "#0b992d",
      locale: "en",
      english_name: "Command"
    }
  }

  its(:id) { is_expected.to eq Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "aspect:Command-en") }
  its(:name) { is_expected.to eq valid_attributes[:name] }
  its(:description) { is_expected.to eq valid_attributes[:description] }
  its(:color) { is_expected.to eq valid_attributes[:color] }
  its(:locale) { is_expected.to eq valid_attributes[:locale] }
  its(:english_name) { is_expected.to eq valid_attributes[:english_name] }
end
