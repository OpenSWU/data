module OpenSWU
  module Data
    class Keyword < ::Data.define(:name, :description, :locale)
      def id
        Data.uuid("keyword", name, locale)
      end
    end
  end
end
