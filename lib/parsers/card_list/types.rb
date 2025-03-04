require "parsers/card_list/base_parser"

module Parsers
  module CardList
    class Types < BaseParser
      def each
        types = Set.new
        Dir["#{cache_dir}*.json"].each do |filename|
          parse_to_types(filename, types)
        end

        types.each do |type|
          yield type
        end
      end

      private

      def parse_to_types(filename, types)
        json = Oj.load_file(filename)

        type = json["attributes"]["type"]["data"]
        types.add OpenSWU::Data::Type.new(
          name: type["attributes"]["name"],
          description: type["attributes"]["description"],
          value: type["attributes"]["value"],
          locale: type["attributes"]["locale"]
        )

        type = json["attributes"]["type2"]["data"]
        return types if type.nil?
        types.add OpenSWU::Data::Type.new(
          name: type["attributes"]["name"],
          description: type["attributes"]["description"],
          value: type["attributes"]["value"],
          locale: type["attributes"]["locale"]
        )
      end
    end
  end
end
