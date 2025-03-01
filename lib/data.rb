require "active_support/core_ext/object/blank"
require "active_support/core_ext/digest/uuid"

Card = Data.define(:title, :subtitle, :card_number, :card_id, :locale, :artist, :expansion_code, :card_count) do
  def expansion_id
    Digest::UUID.uuid_v5(Digest::UUID::OID_NAMESPACE, [expansion_code, locale, card_count].join("-"))
  end
end

Expansion = Data.define(:code, :name, :description, :locale, :card_count) do
  def id
    Digest::UUID.uuid_v5(Digest::UUID::OID_NAMESPACE, [code, locale, card_count].join("-"))
  end
end
