require 'sqlite3'

# Constants
module Config
  DB = SQLite3::Database.open 'db/database.db'
  PIX_TYPES = %w[CPF TEL EMAIL].freeze
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  HELPER = "Parâmetros válidos, exemplos: \n
    --novo [tipo] [chave]
    --transacao [chave-pagador] [chave-recebedor]
    --transacoes [mostra todas transações]".freeze
end
