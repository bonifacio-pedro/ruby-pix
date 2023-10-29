require_relative '../config'
require 'cpf_utils'

# Insert, verify and search
class Pix
  include Config

  def self.insert_data_new_pix(key_type, key)
    # Verify DB
    return 'Key already registered' unless search_pix(key).empty?

    if verify_key(key_type, key)
      DB.execute 'INSERT INTO Pix VALUES (?,?)', [key_type, key]
      puts 'Key successfully added to the database!'
    else
      puts 'We had an error adding the key, please check and try again!'
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

  # Search key with your initial
  def self.search_key_initial(initial)
    search = DB.execute "SELECT * FROM Pix WHERE key LIKE '#{initial}%'"
    return 'No records begin with this combination' if search.empty?

    table = TTY::Table.new(
      header: %w[Key-type Key]
    )
    search.map { |s| table << s }
    table.render(:unicode)
  end

  # Search a pix key
  def self.search_pix(key)
    DB.execute 'SELECT * FROM Pix WHERE key = ?', key
  end
end
