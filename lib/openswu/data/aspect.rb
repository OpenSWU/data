module OpenSWU
  module Data
    class Aspect < ::Data.define(:name, :description, :color, :locale, :english_name)
      def id
        Data.uuid("aspect", name, locale)
      end
    end
  end
end
