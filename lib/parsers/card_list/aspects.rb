require "parsers/card_list/base_parser"

module Parsers
  module CardList
    class Aspects < BaseParser
      def each
        aspects = Set.new
        Dir["#{cache_dir}*.json"].each do |filename|
          parse_to_aspects(filename, aspects)
        end

        aspects.each do |aspect|
          yield aspect
        end
      end

      private

      def parse_to_aspects(filename, aspects)
        json = Oj.load_file(filename)

        json["attributes"]["aspects"]["data"].each do |aspect|
          aspects.add OpenSWU::Data::Aspect.new(
            name: aspect["attributes"]["name"],
            description: aspect["attributes"]["description"],
            color: aspect["attributes"]["color"],
            locale: aspect["attributes"]["locale"],
            english_name: aspect["attributes"]["englishName"]
          )
        end

        json["attributes"]["aspectDuplicates"]["data"].each do |aspect|
          aspects.add OpenSWU::Data::Aspect.new(
            name: aspect["attributes"]["name"],
            description: aspect["attributes"]["description"],
            color: aspect["attributes"]["color"],
            locale: aspect["attributes"]["locale"],
            english_name: aspect["attributes"]["englishName"]
          )
        end
      end
    end
  end
end
