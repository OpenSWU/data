require "csv"
require "fileutils"
require "exporters/base"
require "parsers/card_list/keywords"

module Exporters
  class Keywords < Base
    def export!
      FileUtils.mkdir_p(export_dir) unless Dir.exist?(export_dir)

      CSV.open(export_target, "wb") do |csv|
        csv << %w[id name description locale]
        parser.each do |keyword|
          csv << [keyword.id, keyword.name, keyword.description, keyword.locale]
        end
      end
    end

    private

    def export_filename
      "keywords.csv"
    end

    def parser_klass
      Parsers::CardList::Keywords
    end
  end
end
