require "csv"
require "fileutils"
require "exporters/base"
require "parsers/card_list/aspects"

module Exporters
  class Aspects < Base
    private

    def attr_names
      %w[id name description color locale english_name]
    end

    def export_filename
      "aspects.csv"
    end

    def headers
      %w[id name description color locale english_name]
    end

    def parser_klass
      Parsers::CardList::Aspects
    end
  end
end
