require "parsers/card_list/base_parser"

module Parsers
  module CardList
    class Keywords < BaseParser
      def each
        keywords = Set.new
        Dir["#{cache_dir}*.json"].each do |filename|
          parse_to_keywords(filename, keywords)
        end

        keywords.each do |keyword|
          yield keyword
        end
      end

      private

      def parse_to_keywords(filename, keywords)
        json = Oj.load_file(filename)

        json["attributes"]["keywords"]["data"].each do |keyword|
          keywords.add OpenSWU::Data::Keyword.new(
            name: keyword["attributes"]["name"],
            description: keyword["attributes"]["description"],
            locale: keyword["attributes"]["locale"]
          )
        end
      end
    end
  end
end
