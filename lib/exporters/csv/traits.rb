require "csv"
require "fileutils"
require "exporters/csv/base"
require "parsers/card_list/traits"

module Exporters
  module CSV
    class Traits < Base
      private

      def attr_names
        %w[id name description locale]
      end

      def export_filename
        "traits.csv"
      end

      def headers
        %w[id name description locale]
      end

      def parser_klass
        Parsers::CardList::Traits
      end
    end
  end
end
