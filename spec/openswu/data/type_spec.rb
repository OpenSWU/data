require "spec_helper"
require "openswu/data"

RSpec.describe OpenSWU::Data::Type do
  subject(:card) { OpenSWU::Data::Type.new(*valid_attributes.values) }
  let(:valid_attributes) {
    {
      name: "Unit",
      description: "",
      value: "Unit",
      locale: "en"
    }
  }

  its(:id) { is_expected.to eq Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "type:Unit-en") }
  its(:name) { is_expected.to eq valid_attributes[:name] }
  its(:description) { is_expected.to eq valid_attributes[:description] }
  its(:value) { is_expected.to eq valid_attributes[:value] }
  its(:locale) { is_expected.to eq valid_attributes[:locale] }
end
