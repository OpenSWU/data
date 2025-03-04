require "oj"
require "openswu/data"

module Parsers
  module CardList
    class Arenas
      include Enumerable

      def each
        arenas = Set.new
        Dir["#{cache_dir}*.json"].each do |filename|
          parse_to_arenas(filename, arenas)
        end

        arenas.each do |arena|
          yield arena
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
