require_relative '../config'
require 'cpf_utils'

# Insert, verify and search
class Pix
  include Config

  def self.insert_data_new_pix(key_type, key)
    # Verify DB
    return 'Chave já cadastrada' unless search_pix(key).empty?

    if verify_key(key_type, key)
      DB.execute 'INSERT INTO Pix VALUES (?,?)', [key_type, key]
      puts 'Chave adicionada com sucesso ao banco de dados!'
    else
      puts 'Tivemos um erro ao adicionar a chave, verifique e tente novamente!'
    end
  end

  # Verify if key is valid
  def self.verify_key(key_type, key)
    if key_type == 'EMAIL'
      true if key =~ EMAIL_REGEX
    elsif key_type == 'CPF'
      true if CpfUtils.valid_cpf?(key)
    end
    true
  end

  # Search a pix key
  def self.search_pix(key)
    DB.execute 'SELECT * FROM Pix WHERE key = ?', key
  end
end
