module OpenSWU
  module Data
    class Type < ::Data.define(:name, :description, :value, :locale)
      def id
        Data.uuid("type", name, locale)
      end
    end
  end
end
