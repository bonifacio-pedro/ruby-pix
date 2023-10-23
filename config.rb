require 'sqlite3'

# Constants
module Config
    DB = SQLite3::Database.open "db/database.db"
    PIX_TYPES = ["CPF","TEL","EMAIL"]
    EMAIL_REGEX =/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    HELPER = "Adicione um parâmetro válido, exemplos: \n
    --novo [tipo] [chave] \n
    --transacao [chave-pagador] [chave-recebedor]" 
end