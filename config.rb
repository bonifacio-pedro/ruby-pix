require 'sqlite3'

# Constants
module Config
  DB = SQLite3::Database.open 'db/database.db'
  PIX_TYPES = %w[CPF CELL EMAIL].freeze
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  HELPER = "Valid parameters, examples: \n
    --new [type] [key]
    --transaction [payer-key] [receiver-key]
    --transactions [show all transactions]
    --search [key-search]
    --flush (delete db)".freeze
end
