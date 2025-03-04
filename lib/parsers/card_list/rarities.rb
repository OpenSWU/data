require "parsers/card_list/base_parser"

module Parsers
  module CardList
    class Rarities < BaseParser
      def each
        rarities = Set.new
        Dir["#{cache_dir}*.json"].each do |filename|
          parse_to_rarities(filename, rarities)
        end

        rarities.each do |rarity|
          yield rarity
        end
      end

      private

      def parse_to_rarities(filename, rarities)
        json = Oj.load_file(filename)
        trait = json["attributes"]["rarity"]["data"]

        rarities.add OpenSWU::Data::Rarity.new(
          name: trait["attributes"]["name"],
          character: trait["attributes"]["character"],
          color: trait["attributes"]["color"],
          locale: trait["attributes"]["locale"],
          english_name: trait["attributes"]["englishName"]
        )
      end
    end
  end
end
