require "csv"
require "fileutils"
require "exporters/base"
require "parsers/card_list/rarities"

module Exporters
  class Rarities < Base
    def export!
      FileUtils.mkdir_p(export_dir) unless Dir.exist?(export_dir)

      CSV.open(export_target, "wb") do |csv|
        csv << %w[id name character color locale english_name]
        parser.each do |rarity|
          csv << [rarity.id, rarity.name, rarity.character, rarity.color, rarity.locale, rarity.english_name]
        end
      end
    end

    private

    def export_filename
      "rarities.csv"
    end

    def parser_klass
      Parsers::CardList::Rarities
    end
  end
end
