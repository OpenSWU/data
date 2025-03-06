module OpenSWU
  module Data
    class Arena < ::Data.define(:name, :description, :locale)
      def id
        Data.uuid("arena", name, locale)
      end
    end
  end
end
