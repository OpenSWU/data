require "csv"
require "fileutils"
require "exporters/base"
require "parsers/card_list/aspects"

module Exporters
  class Aspects < Base
    def export!
      FileUtils.mkdir_p(export_dir) unless Dir.exist?(export_dir)

      CSV.open(export_target, "wb") do |csv|
        csv << %w[id name description color locale english_name]
        parser.each do |aspect|
          csv << [aspect.id, aspect.name, aspect.description, aspect.color, aspect.locale, aspect.english_name]
        end
      end
    end

    private

    def export_filename
      "aspects.csv"
    end

    def parser_klass
      Parsers::CardList::Aspects
    end
  end
end
