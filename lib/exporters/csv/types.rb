require "csv"
require "fileutils"
require "exporters/csv/base"
require "parsers/card_list/types"

module Exporters
  module CSV
    class Types < Base
      private

      def attr_names
        %w[id name description value locale]
      end

      def export_filename
        "types.csv"
      end

      def headers
        %w[id name description value locale]
      end

      def parser_klass
        Parsers::CardList::Types
      end
    end
  end
end
