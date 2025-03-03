require "spec_helper"
require "openswu/data"

RSpec.describe OpenSWU::Data::Keyword do
  subject(:card) { OpenSWU::Data::Keyword.new(*valid_attributes.values) }
  let(:valid_attributes) {
    {
      name: "Sentinel",
      description: "",
      locale: "en"
    }
  }

  its(:id) { is_expected.to eq Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "keyword:Sentinel-en") }
  its(:name) { is_expected.to eq valid_attributes[:name] }
  its(:description) { is_expected.to eq valid_attributes[:description] }
  its(:locale) { is_expected.to eq valid_attributes[:locale] }
end
