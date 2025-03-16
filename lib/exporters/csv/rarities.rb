require "csv"
require "fileutils"
require "exporters/csv/base"
require "parsers/card_list/rarities"

module Exporters
  module CSV
    class Rarities < Base
      private

      def attr_names
        %w[id name character color locale english_name]
      end

      def export_filename
        "rarities.csv"
      end

      def headers
        %w[id name character color locale english_name]
      end

      def parser_klass
        Parsers::CardList::Rarities
      end
    end
  end
end
