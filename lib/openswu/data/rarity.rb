module OpenSWU
  module Data
    class Rarity < ::Data.define(:name, :character, :color, :locale, :english_name)
      def id
        Data.uuid("rarity", name, locale)
      end
    end
  end
end
