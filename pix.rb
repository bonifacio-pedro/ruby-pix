require_relative 'config'
require 'cpf_utils'
include Config

class Pix
    def self.insert_data_new_pix(key_type, key)
        # Verify DB 
        if self.search_pix(key).length != 0
            return "Chave já cadastrada"
        end

        if self.verify_key(key_type, key)
            DB.execute "INSERT INTO Pix VALUES (?,?)", [key_type,key]
            return puts "Chave adicionada com sucesso ao banco de dados!"
        end
    end

    # Verify if key is valid
    def self.verify_key(key_type, key)
        if key_type == "EMAIL"
            if key =~ EMAIL_REGEX
                return true
            else
                puts "Chave de email inválida"
                return false
            end
        elsif key_type == "CPF"
            if CpfUtils.valid_cpf?(key)
                return true
            else
                puts "Chave de CPF inválida"
            end
        else
            return true
        end
    end

    # Search a pix key
    def self.search_pix(key)
        searched = DB.execute "SELECT * FROM Pix WHERE key = ?", key
        return searched
    end
end