require "openswu"

require "active_support/core_ext/object/blank"
require "active_support/core_ext/digest/uuid"

module OpenSWU
  module Data
    Arena = ::Data.define(:name, :description, :locale) do
      def id
        Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "arena:#{name}-#{locale}")
      end
    end

    Aspect = ::Data.define(:name, :description, :color, :locale, :english_name) do
      def id
        Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "aspect:#{name}-#{locale}")
      end
    end

    Card = ::Data.define(:title, :subtitle, :card_number, :card_id, :locale, :artist, :expansion_code, :card_count) do
      def id
        Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "card:" + [expansion_code, locale, card_number, card_count].join("-"))
      end

      def expansion_id
        Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "expansion:" + [expansion_code, locale, card_count].join("-"))
      end
    end

    Expansion = ::Data.define(:code, :name, :description, :locale, :card_count) do
      def id
        Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "expansion:" + [code, locale, card_count].join("-"))
      end
    end

    Keyword = ::Data.define(:name, :description, :locale) do
      def id
        Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "keyword:#{name}-#{locale}")
      end
    end

    Rarity = ::Data.define(:name, :character, :color, :locale, :english_name) do
      def id
        Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "rarity:#{name}-#{locale}")
      end
    end

    Trait = ::Data.define(:name, :description, :locale) do
      def id
        Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "trait:#{name}-#{locale}")
      end
    end

    Type = ::Data.define(:name, :description, :value, :locale) do
      def id
        Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "type:#{name}-#{locale}")
      end
    end
  end
end
