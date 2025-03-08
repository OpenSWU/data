require "csv"
require "fileutils"
require "exporters/base"
require "parsers/card_list/cards"

module Exporters
  class Cards < Base
    def export!
      FileUtils.mkdir_p(export_dir) unless Dir.exist?(export_dir)

      CSV.open(export_target, "wb") do |csv|
        csv << %w[id swu_card_id title subtitle card_number locale artist expansion_id front_art_url
          front_art_is_horizontal back_art_url back_art_is_horizontal has_foil is_hyperspace is_showcase play_cost
          base_hp base_power unique upgrade_hp upgrade_power rarity_id front_type_id back_type_id aspect_ids arena_ids
          trait_ids keyword_ids]
        parser.each do |card|
          csv << [card.id, card.card_id, card.title, card.subtitle, card.card_number, card.locale, card.artist,
            card.expansion_id, card.front_art_url, card.front_art_horizontal, card.back_art_url,
            card.back_art_horizontal, card.has_foil_printing, card.hyperspace_printing, card.showcase_printing,
            card.play_cost, card.base_hp, card.base_power, card.unique, card.upgrade_hp, card.upgrade_power,
            card.rarity_id, card.front_type_id, card.back_type_id, card.aspect_ids.join(";"), card.arena_ids.join(";"),
            card.trait_ids.join(";"), card.keyword_ids.join(";")]
        end
      end
    end

    private

    def export_filename
      "cards.csv"
    end

    def parser_klass
      Parsers::CardList::Cards
    end
  end
end
