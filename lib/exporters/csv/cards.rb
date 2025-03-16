require "csv"
require "fileutils"
require "exporters/csv/base"
require "parsers/card_list/cards"

module Exporters
  module CSV
    class Cards < Base
      private

      def attr_names
        %w[id card_id title subtitle card_number locale artist expansion_id front_art_url front_art_horizontal
          back_art_url back_art_horizontal has_foil_printing hyperspace_printing showcase_printing play_cost base_hp
          base_power unique upgrade_hp upgrade_power rarity_id front_type_id back_type_id csv_aspect_ids csv_arena_ids
          csv_trait_ids csv_keyword_ids]
      end

      def export_filename
        "cards.csv"
      end

      def headers
        %w[id swu_card_id title subtitle card_number locale artist expansion_id front_art_url front_art_is_horizontal
          back_art_url back_art_is_horizontal has_foil is_hyperspace is_showcase play_cost base_hp base_power unique
          upgrade_hp upgrade_power rarity_id front_type_id back_type_id aspect_ids arena_ids trait_ids keyword_ids]
      end

      def parser_klass
        Parsers::CardList::Cards
      end
    end
  end
end
