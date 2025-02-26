require "oj"
require "data"

module Parsers
  module CardList
    class Cards
      include Enumerable

      def each
        Dir["#{cache_dir}*.json"].each do |filename|
          yield parse_to_card(filename)
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

      def parse_to_card(filename)
        json = Oj.load_file(filename)
        ::Card.new(
          title: json["attributes"]["title"],
          subtitle: json["attributes"]["subtitle"],
          card_number: json["attributes"]["cardNumber"],
          card_id: json["attributes"]["cardId"] || json["attributes"]["cardUid"],
          locale: json["attributes"]["locale"],
          artist: json["attributes"]["artist"],
          expansion_code: json["attributes"]["expansion"]["code"]
        )
      end
    end
  end
end
