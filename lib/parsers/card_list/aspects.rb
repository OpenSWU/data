require "oj"
require "openswu/data"

module Parsers
  module CardList
    class Aspects
      include Enumerable

      def each
        aspects = Set.new
        Dir["#{cache_dir}*.json"].each do |filename|
          parse_to_aspects(filename, aspects)
        end

        aspects.each do |aspect|
          yield aspect
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
