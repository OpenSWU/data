require "csv"
require "fileutils"
require "exporters/base"
require "parsers/card_list/expansions"

module Exporters
  class Expansions < Base
    def export!
      FileUtils.mkdir_p(export_dir) unless Dir.exist?(export_dir)

      CSV.open(export_target, "wb") do |csv|
        csv << %w[id code name description locale card_count]
        parser.each do |expansion|
          csv << [expansion.id, expansion.code, expansion.name, expansion.description, expansion.locale, expansion.card_count]
        end
      end
    end

    private

    def export_filename
      "expansions.csv"
    end

    def parser_klass
      Parsers::CardList::Expansions
    end
  end
end
