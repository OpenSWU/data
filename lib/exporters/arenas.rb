require "csv"
require "fileutils"
require "parsers/card_list/arenas"

module Exporters
  class Arenas
    def initialize(cache_dir, export_dir)
      @parser = Parsers::CardList::Arenas.load_cache(cache_dir)
      @export_dir = export_dir
      @export_target = "#{export_dir}/arenas.csv"
    end

    def export!
      FileUtils.mkdir_p(@export_dir) unless Dir.exist?(@export_dir)

      CSV.open(@export_target, "wb") do |csv|
        csv << %w[id name description locale]
        @parser.each do |arena|
          csv << [arena.id, arena.name, arena.description, arena.locale]
        end
      end
    end
  end
end
