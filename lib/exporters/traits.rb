require "csv"
require "fileutils"
require "exporters/base"
require "parsers/card_list/traits"

module Exporters
  class Traits < Base
    def export!
      FileUtils.mkdir_p(export_dir) unless Dir.exist?(export_dir)

      CSV.open(export_target, "wb") do |csv|
        csv << %w[id name description locale]
        parser.each do |trait|
          csv << [trait.id, trait.name, trait.description, trait.locale]
        end
      end
    end

    private

    def export_filename
      "traits.csv"
    end

    def parser_klass
      Parsers::CardList::Traits
    end
  end
end
