require "csv"
require "fileutils"
require "exporters/base"
require "parsers/card_list/arenas"

module Exporters
  class Arenas < Base
    private

    def attr_names
      %w[id name description locale]
    end

    def headers
      %w[id name description locale]
    end

    def export_filename
      "arenas.csv"
    end

    def parser_klass
      Parsers::CardList::Arenas
    end
  end
end
