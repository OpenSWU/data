require "openswu"

require "active_support/core_ext/object/blank"
require "active_support/core_ext/digest/uuid"

module OpenSWU
  module Data
    def self.uuid(namespace, *name_parts)
      value = name_parts.join("-")
      Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "#{namespace}:#{value}")
    end

    Arena = ::Data.define(:name, :description, :locale) do
      def id
        Data.uuid("arena", name, locale)
      end
    end

    Aspect = ::Data.define(:name, :description, :color, :locale, :english_name) do
      def id
        Data.uuid("aspect", name, locale)
      end
    end

    Card = ::Data.define(:title, :subtitle, :card_number, :card_id, :locale, :artist, :expansion_code,
      :card_count, :front_art_url, :front_art_horizontal, :back_art_url, :back_art_horizontal, :has_foil_printing,
      :hyperspace_printing, :showcase_printing, :play_cost, :base_hp, :base_power, :unique, :upgrade_hp,
      :upgrade_power, :rarity_id, :front_type_id, :back_type_id, :aspect_ids, :arena_ids) do
      def id
        Data.uuid("card", expansion_code, locale, card_number, card_count)
      end

      def expansion_id
        Data.uuid("expansion", expansion_code, locale, card_count)
      end
    end

    Expansion = ::Data.define(:code, :name, :description, :locale, :card_count) do
      def id
        Data.uuid("expansion", code, locale, card_count)
      end
    end

    Keyword = ::Data.define(:name, :description, :locale) do
      def id
        Data.uuid("keyword", name, locale)
      end
    end

    Rarity = ::Data.define(:name, :character, :color, :locale, :english_name) do
      def id
        Data.uuid("rarity", name, locale)
      end
    end

    Trait = ::Data.define(:name, :description, :locale) do
      def id
        Data.uuid("trait", name, locale)
      end
    end

    Type = ::Data.define(:name, :description, :value, :locale) do
      def id
        Data.uuid("type", name, locale)
      end
    end
  end
end
