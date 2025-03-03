require "spec_helper"
require "data"

RSpec.describe Rarity do
  subject(:card) { Rarity.new(*valid_attributes.values) }
  let(:valid_attributes) {
    {
      name: "Rare",
      character: "R",
      color: "#964d02",
      locale: "en",
      english_name: "Rare"
    }
  }

  its(:id) { is_expected.to eq Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "rarity:Rare-en") }
  its(:name) { is_expected.to eq valid_attributes[:name] }
  its(:character) { is_expected.to eq valid_attributes[:character] }
  its(:color) { is_expected.to eq valid_attributes[:color] }
  its(:locale) { is_expected.to eq valid_attributes[:locale] }
  its(:english_name) { is_expected.to eq valid_attributes[:english_name] }
end
