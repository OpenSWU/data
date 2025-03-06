module OpenSWU
  module Data
    class Expansion < ::Data.define(:code, :name, :description, :locale, :card_count)
      def id
        Data.uuid("expansion", code, locale, card_count)
      end
    end
  end
end
