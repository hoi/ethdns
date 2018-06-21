class EthAddress < ApplicationRecord

  ### CLASS METHODS ###

  class << self

    def is_address(str)
      return str[0..1] == "0x" && str.length == 42
    end

  end

end
