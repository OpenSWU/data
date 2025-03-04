require "parsers/card_list/base_parser"

module Parsers
  module CardList
    class Arenas < BaseParser
      def each
        arenas = Set.new
        Dir["#{cache_dir}*.json"].each do |filename|
          parse_to_arenas(filename, arenas)
        end

        arenas.each do |arena|
          yield arena
        end
      end

      private

      def parse_to_arenas(filename, arenas)
        json = Oj.load_file(filename)

        json["attributes"]["arenas"]["data"].each do |arena|
          arenas.add OpenSWU::Data::Arena.new(
            name: arena["attributes"]["name"],
            description: arena["attributes"]["description"],
            locale: arena["attributes"]["locale"]
          )
        end
      end
    end
  end
end
