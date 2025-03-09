require "csv"
require "fileutils"
require "exporters/base"
require "parsers/card_list/expansions"

module Exporters
  class Expansions < Base
    private

    def attr_names
      %w[id code name description locale card_count]
    end

    def export_filename
      "expansions.csv"
    end

    def headers
      %w[id code name description locale card_count]
    end

    def parser_klass
      Parsers::CardList::Expansions
    end
  end
end
