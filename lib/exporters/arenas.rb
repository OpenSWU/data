require "csv"
require "fileutils"
require "exporters/base"
require "parsers/card_list/arenas"

module Exporters
  class Arenas < Base
    def export!
      FileUtils.mkdir_p(export_dir) unless Dir.exist?(export_dir)

      CSV.open(export_target, "wb") do |csv|
        csv << %w[id name description locale]
        parser.each do |arena|
          csv << [arena.id, arena.name, arena.description, arena.locale]
        end
      end
    end

    private

    def export_filename
      "arenas.csv"
    end

    def parser_klass
      Parsers::CardList::Arenas
    end
  end
end
