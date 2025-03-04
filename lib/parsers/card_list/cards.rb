require "parsers/card_list/base_parser"

module Parsers
  module CardList
    class Cards < BaseParser
      def each
        Dir["#{cache_dir}*.json"].each do |filename|
          yield parse_to_card(filename)
        end
      end

      private

      def parse_to_card(filename)
        json = Oj.load_file(filename)
        OpenSWU::Data::Card.new(
          title: json["attributes"]["title"],
          subtitle: json["attributes"]["subtitle"],
          card_number: json["attributes"]["cardNumber"],
          card_id: json["attributes"]["cardId"] || json["attributes"]["cardUid"],
          locale: json["attributes"]["locale"],
          artist: json["attributes"]["artist"],
          expansion_code: json["attributes"]["expansion"]["data"]["attributes"]["code"],
          card_count: json["attributes"]["cardCount"],
          front_art_url: json["attributes"]["artFront"]["data"]["attributes"]["url"],
          front_art_horizontal: !!json["attributes"]["artFrontHorizontal"],
          back_art_url: json["attributes"]["artBack"]["data"]&.[]("attributes")&.[]("url"),
          back_art_horizontal: !!json["attributes"]["artBackHorizontal"],
          has_foil_printing: json["attributes"]["hasFoil"],
          hyperspace_printing: json["attributes"]["hyperspace"],
          showcase_printing: json["attributes"]["showcase"],
          play_cost: json["attributes"]["cost"],
          base_hp: json["attributes"]["hp"],
          base_power: json["attributes"]["power"],
          unique: json["attributes"]["unique"],
          upgrade_hp: json["attributes"]["upgradeHp"],
          upgrade_power: json["attributes"]["upgradePower"]
        )
      end
    end
  end
end
