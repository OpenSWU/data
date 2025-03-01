Card = Data.define(:title, :subtitle, :card_number, :card_id, :locale, :artist, :expansion_code)
Expansion = Data.define(:code, :name, :description, :locale, :card_count) do
  def id
    @id ||= Digest::UUID.uuid_v5(Digest::UUID::OID_NAMESPACE, [code, locale, card_count].join("-"))
  end
end
