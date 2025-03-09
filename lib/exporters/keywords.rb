require "csv"
require "fileutils"
require "exporters/base"
require "parsers/card_list/keywords"

module Exporters
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
