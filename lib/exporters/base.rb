module Exporters
  class Base
    def initialize(cache_dir, export_dir)
      @parser = parser_klass.load_cache(cache_dir)
      @export_dir = export_dir
      @export_target = "#{export_dir}/#{export_filename}"
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
