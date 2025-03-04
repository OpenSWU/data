require "oj"
require "openswu/data"

module Parsers
  module CardList
    class BaseParser
      include Enumerable

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
    end
  end
end
