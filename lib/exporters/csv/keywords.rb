require "csv"
require "fileutils"
require "exporters/csv/base"
require "parsers/card_list/keywords"

module Exporters
  module CSV
    class Keywords < Base
      private

      def attr_names
        %w[id name description locale]
      end

      def export_filename
        "keywords.csv"
      end

      def headers
        %w[id name description locale]
      end

      def parser_klass
        Parsers::CardList::Keywords
      end
    end
  end
end
