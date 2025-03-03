require "spec_helper"
require "openswu/data"

RSpec.describe OpenSWU::Data::Card do
  subject(:card) { OpenSWU::Data::Card.new(*valid_attributes.values) }
  let(:valid_attributes) {
    {
      title: "Luke Skywalker",
      subtitle: "Faithful Friend",
      card_number: 5,
      card_id: "2579145458",
      locale: "en",
      artist: "Borja Pindado",
      expansion_code: "SOR",
      card_count: 252,
      front_art_url: "https://cdn.starwarsunlimited.com/example.png",
      front_art_horizontal: false,
      back_art_url: nil,
      back_art_horizontal: nil,
      has_foil_printing: false,
      hyperspace_printing: false,
      showcase_printing: false
    }
  }

  its(:id) { is_expected.to eq Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "card:SOR-en-5-252") }
  its(:title) { is_expected.to eq valid_attributes[:title] }
  its(:subtitle) { is_expected.to eq valid_attributes[:subtitle] }
  its(:card_number) { is_expected.to eq valid_attributes[:card_number] }
  its(:card_id) { is_expected.to eq valid_attributes[:card_id] }
  its(:locale) { is_expected.to eq valid_attributes[:locale] }
  its(:artist) { is_expected.to eq valid_attributes[:artist] }
  its(:expansion_code) { is_expected.to eq valid_attributes[:expansion_code] }
  its(:card_count) { is_expected.to eq valid_attributes[:card_count] }
  its(:front_art_url) { is_expected.to eq valid_attributes[:front_art_url] }
  its(:front_art_horizontal) { is_expected.to eq valid_attributes[:front_art_horizontal] }
  its(:back_art_url) { is_expected.to eq valid_attributes[:back_art_url] }
  its(:back_art_horizontal) { is_expected.to eq valid_attributes[:back_art_horizontal] }
  its(:has_foil_printing) { is_expected.to eq valid_attributes[:has_foil_printing] }
  its(:hyperspace_printing) { is_expected.to eq valid_attributes[:hyperspace_printing] }
  its(:showcase_printing) { is_expected.to eq valid_attributes[:showcase_printing] }
  its(:expansion_id) { is_expected.to eq Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "expansion:SOR-en-252") }
end
