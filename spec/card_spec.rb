require "spec_helper"
require "card"

RSpec.describe Card do
  subject(:card) { Card.new(*valid_attributes.values) }
  let(:valid_attributes) {
    {
      title: "Luke Skywalker",
      subtitle: "Faithful Friend",
      card_number: 5,
      card_id: "2579145458",
      locale: "en",
      artist: "Borja Pindado"
    }
  }

  its(:title) { is_expected.to eq valid_attributes[:title] }
  its(:subtitle) { is_expected.to eq valid_attributes[:subtitle] }
  its(:card_number) { is_expected.to eq valid_attributes[:card_number] }
  its(:card_id) { is_expected.to eq valid_attributes[:card_id] }
  its(:locale) { is_expected.to eq valid_attributes[:locale] }
  its(:artist) { is_expected.to eq valid_attributes[:artist] }
end