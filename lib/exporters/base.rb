module Exporters
  class Base
    def initialize(cache_dir, export_dir)
      @parser = parser_klass.load_cache(cache_dir)
      @export_dir = export_dir
      @export_target = "#{export_dir}/#{export_filename}"
    end

    def export!
      FileUtils.mkdir_p(export_dir) unless Dir.exist?(export_dir)

      CSV.open(export_target, "wb") do |csv|
        csv << headers
        parser.each do |datum|
          csv << attr_names.collect do |attr|
            datum.send(attr)
          end
        end
      end
    end

    private

    attr_reader :parser, :export_dir, :export_target

    def parser_klass
      raise NoMethodError, "define `parser_klass` for #{self.class}"
    end

    def export_filename
      raise NoMethodError, "define `export_filename` for #{self.class}"
    end
  end
end
