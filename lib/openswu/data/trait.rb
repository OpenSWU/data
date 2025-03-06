module OpenSWU
  module Data
    class Trait < ::Data.define(:name, :description, :locale)
      def id
        Data.uuid("trait", name, locale)
      end
    end
  end
end
