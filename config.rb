# frozen_string_literal: true

# Constants
module Config
  PIX_TYPES = %w[CPF CELL EMAIL].freeze
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d]+(\.[a-z\d]+)*\.[a-z]+\z/i.freeze
  HELPER = "Valid parameters, examples: \n
    --new [username] [key-type] [key]
    --transaction [payer-key] [receiver-key] [transaction-price]
    --transactions [show all transactions]
    --search [key-search]
    --db (configure db)"
end
