require "spec_helper"
require "data"

RSpec.describe Card do
  subject(:card) { Card.new(*valid_attributes.values) }
  let(:valid_attributes) {
    {
      title: "Luke Skywalker",
      subtitle: "Faithful Friend",
      card_number: 5,
      card_id: "2579145458",
      locale: "en",
      artist: "Borja Pindado",
      expansion_code: "SOR",
      card_count: 252
    }
  }

  its(:id) { is_expected.to eq Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "SOR-en-5-252") }
  its(:title) { is_expected.to eq valid_attributes[:title] }
  its(:subtitle) { is_expected.to eq valid_attributes[:subtitle] }
  its(:card_number) { is_expected.to eq valid_attributes[:card_number] }
  its(:card_id) { is_expected.to eq valid_attributes[:card_id] }
  its(:locale) { is_expected.to eq valid_attributes[:locale] }
  its(:artist) { is_expected.to eq valid_attributes[:artist] }
  its(:expansion_code) { is_expected.to eq valid_attributes[:expansion_code] }
  its(:card_count) { is_expected.to eq valid_attributes[:card_count] }
  its(:expansion_id) { is_expected.to eq Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "SOR-en-252") }
end
