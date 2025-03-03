require "openswu"

require "active_support/core_ext/object/blank"
require "active_support/core_ext/digest/uuid"

Aspect = Data.define(:name, :description, :color, :locale, :english_name) do
  def id
    Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "aspect:#{name}")
  end
end

Card = Data.define(:title, :subtitle, :card_number, :card_id, :locale, :artist, :expansion_code, :card_count) do
  def id
    Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "card:" + [expansion_code, locale, card_number, card_count].join("-"))
  end

  def expansion_id
    Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "expansion:" + [expansion_code, locale, card_count].join("-"))
  end
end

Expansion = Data.define(:code, :name, :description, :locale, :card_count) do
  def id
    Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "expansion:" + [code, locale, card_count].join("-"))
  end
end
