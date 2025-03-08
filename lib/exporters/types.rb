require "csv"
require "fileutils"
require "exporters/base"
require "parsers/card_list/types"

module Exporters
  class Types < Base
    def export!
      FileUtils.mkdir_p(export_dir) unless Dir.exist?(export_dir)

      CSV.open(export_target, "wb") do |csv|
        csv << %w[id name description value locale]
        parser.each do |trait|
          csv << [trait.id, trait.name, trait.description, trait.value, trait.locale]
        end
      end
    end

    private

    def export_filename
      "types.csv"
    end

    def parser_klass
      Parsers::CardList::Types
    end
  end
end
