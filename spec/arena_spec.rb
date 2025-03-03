require "spec_helper"
require "data"

RSpec.describe Arena do
  subject(:card) { Arena.new(*valid_attributes.values) }
  let(:valid_attributes) {
    {
      name: "Ground",
      description: "",
      locale: "en"
    }
  }

  its(:id) { is_expected.to eq Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "arena:Ground-en") }
  its(:name) { is_expected.to eq valid_attributes[:name] }
  its(:description) { is_expected.to eq valid_attributes[:description] }
  its(:locale) { is_expected.to eq valid_attributes[:locale] }
end
