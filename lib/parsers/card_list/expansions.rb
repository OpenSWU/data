require "active_support/core_ext/object/blank"
require "active_support/core_ext/digest/uuid"
require "oj"
require "data"

module Parsers
  module CardList
    class Expansions
      include Enumerable

      def each
        expansions = Set.new
        Dir["#{cache_dir}*.json"].each do |filename|
          expansions.add(parse_to_expansion(filename))
        end

        expansions.each do |expansion|
          yield expansion
        end
      end

      def self.load_cache(cache_dir)
        parser = new
        parser.load_cache cache_dir
        parser
      end

      def load_cache(cache_dir)
        @cache_dir = cache_dir
      end

      def size
        Dir["#{cache_dir}*.json"].count
      end

      private

      attr_reader :cache_dir

      def parse_to_expansion(filename)
        json = Oj.load_file(filename)

        card_count = json["attributes"]["cardCount"]
        code = json["attributes"]["expansion"]["data"]["attributes"]["code"]
        locale = json["attributes"]["expansion"]["data"]["attributes"]["locale"]

        ::Expansion.new(
          id: Digest::UUID.uuid_v5(Digest::UUID::OID_NAMESPACE, "#{code}-#{locale}-#{card_count}"),
          code: code,
          name: json["attributes"]["expansion"]["data"]["attributes"]["name"],
          description: json["attributes"]["expansion"]["data"]["attributes"]["description"],
          locale: locale,
          card_count: card_count
        )
      end
    end
  end
end
