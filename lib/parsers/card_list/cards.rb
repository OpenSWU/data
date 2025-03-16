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
          upgrade_power: json["attributes"]["upgradePower"],
          rarity_id: parse_rarity_id(json["attributes"]["rarity"]["data"]["attributes"]),
          front_type_id: parse_type_id(json["attributes"]["type"]["data"]["attributes"]),
          back_type_id: parse_type_id(json["attributes"]["type2"]["data"]&.[]("attributes")),
          aspect_ids: parse_aspect_ids(json["attributes"]["aspects"]["data"], json["attributes"]["aspectDuplicates"]["data"]),
          arena_ids: parse_arena_ids(json["attributes"]["arenas"]["data"]),
          trait_ids: parse_trait_ids(json["attributes"]["traits"]["data"]),
          keyword_ids: parse_keyword_ids(json["attributes"]["keywords"]["data"])
        )
      end

      def parse_arena_ids(json)
        json.collect do |arena|
          ::OpenSWU::Data.uuid("arena", arena["attributes"]["name"], arena["attributes"]["locale"])
        end
      end

      def parse_aspect_ids(primary_aspects, duplicate_aspects)
        primary_aspects.collect { |aspect|
          ::OpenSWU::Data.uuid("aspect", aspect["attributes"]["name"], aspect["attributes"]["locale"])
        }.concat(duplicate_aspects.collect { |aspect|
          ::OpenSWU::Data.uuid("aspect", aspect["attributes"]["name"], aspect["attributes"]["locale"])
        })
      end

      def parse_keyword_ids(json)
        json.collect do |keywords|
          ::OpenSWU::Data.uuid("keyword", keywords["attributes"]["name"], keywords["attributes"]["locale"])
        end
      end

      def parse_rarity_id(json)
        ::OpenSWU::Data.uuid("rarity", json["name"], json["locale"])
      end

      def parse_trait_ids(json)
        json.collect do |trait|
          ::OpenSWU::Data.uuid("trait", trait["attributes"]["name"], trait["attributes"]["locale"])
        end
      end

      def parse_type_id(json = nil)
        return if json.nil?

        ::OpenSWU::Data.uuid("type", json["name"], json["locale"])
      end
    end
  end
end
