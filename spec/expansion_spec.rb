require "spec_helper"
require "data"

RSpec.describe Expansion do
  subject(:card) { Expansion.new(*valid_attributes.values) }
  let(:valid_attributes) {
    {
      id: Digest::UUID.uuid_v5(Digest::UUID::OID_NAMESPACE, "SHD-en-262"),
      code: "SHD",
      name: "Shadows of the Galaxy",
      description: "",
      locale: "en",
      card_count: 262
    }
  }

  its(:id) { is_expected.to eq Digest::UUID.uuid_v5(Digest::UUID::OID_NAMESPACE, "SHD-en-262") }
  its(:code) { is_expected.to eq valid_attributes[:code] }
  its(:name) { is_expected.to eq valid_attributes[:name] }
  its(:description) { is_expected.to eq valid_attributes[:description] }
  its(:locale) { is_expected.to eq valid_attributes[:locale] }
  its(:card_count) { is_expected.to eq valid_attributes[:card_count] }
end
