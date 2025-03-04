require "parsers/card_list/base_parser"

module Parsers
  module CardList
    class Expansions < BaseParser
      def each
        expansions = Set.new
        Dir["#{cache_dir}*.json"].each do |filename|
          expansions.add(parse_to_expansion(filename))
        end

        expansions.each do |expansion|
          yield expansion
        end
      end

      private

      def parse_to_expansion(filename)
        json = Oj.load_file(filename)

        OpenSWU::Data::Expansion.new(
          code: json["attributes"]["expansion"]["data"]["attributes"]["code"],
          name: json["attributes"]["expansion"]["data"]["attributes"]["name"],
          description: json["attributes"]["expansion"]["data"]["attributes"]["description"],
          locale: json["attributes"]["expansion"]["data"]["attributes"]["locale"],
          card_count: json["attributes"]["cardCount"]
        )
      end
    end
  end
end
