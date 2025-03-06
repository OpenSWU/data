module OpenSWU
  module Data
    class Card < ::Data.define(:title, :subtitle, :card_number, :card_id, :locale, :artist, :expansion_code,
      :card_count, :front_art_url, :front_art_horizontal, :back_art_url, :back_art_horizontal, :has_foil_printing,
      :hyperspace_printing, :showcase_printing, :play_cost, :base_hp, :base_power, :unique, :upgrade_hp,
      :upgrade_power, :rarity_id, :front_type_id, :back_type_id, :aspect_ids, :arena_ids, :trait_ids, :keyword_ids)
      def id
        Data.uuid("card", expansion_code, locale, card_number, card_count)
      end

      def expansion_id
        Data.uuid("expansion", expansion_code, locale, card_count)
      end
    end
  end
end
