require "csv"
require "fileutils"
require "parsers/card_list/aspects"

module Exporters
  class Aspects
    def initialize(cache_dir, export_dir)
      @parser = Parsers::CardList::Aspects.load_cache(cache_dir)
      @export_dir = export_dir
      @export_target = "#{export_dir}/aspects.csv"
    end

    def export!
      FileUtils.mkdir_p(@export_dir) unless Dir.exist?(@export_dir)

      CSV.open(@export_target, "wb") do |csv|
        csv << %w[id name description color locale english_name]
        @parser.each do |aspect|
          csv << [aspect.id, aspect.name, aspect.description, aspect.color, aspect.locale, aspect.english_name]
        end
      end
    end
  end
end
