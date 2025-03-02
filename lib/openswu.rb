require "active_support/core_ext/object/blank"
require "active_support/core_ext/digest/uuid"

module OpenSWU
  V5_UUID = Digest::UUID.uuid_v5(Digest::UUID::URL_NAMESPACE, "https://github.com/OpenSWU/")
end
