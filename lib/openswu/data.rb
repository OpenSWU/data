require "active_support/core_ext/object/blank"
require "active_support/core_ext/digest/uuid"

require "openswu"
require "openswu/data/arena"
require "openswu/data/aspect"
require "openswu/data/card"
require "openswu/data/expansion"
require "openswu/data/keyword"
require "openswu/data/rarity"
require "openswu/data/trait"
require "openswu/data/type"

module OpenSWU
  module Data
    def self.uuid(namespace, *name_parts)
      value = name_parts.join("-")
      Digest::UUID.uuid_v5(OpenSWU::V5_UUID, "#{namespace}:#{value}")
    end
  end
end
