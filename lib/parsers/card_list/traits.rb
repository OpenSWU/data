require "parsers/card_list/base_parser"

module Parsers
  module CardList
    class Traits < BaseParser
      def each
        traits = Set.new
        Dir["#{cache_dir}*.json"].each do |filename|
          parse_to_traits(filename, traits)
        end

        traits.each do |trait|
          yield trait
        end
      end

      private

      def parse_to_traits(filename, traits)
        json = Oj.load_file(filename)

        json["attributes"]["traits"]["data"].each do |trait|
          traits.add OpenSWU::Data::Trait.new(
            name: trait["attributes"]["name"],
            description: trait["attributes"]["description"],
            locale: trait["attributes"]["locale"]
          )
        end
      end
    end
  end
end
